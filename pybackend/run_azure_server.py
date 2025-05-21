#!/usr/bin/env python3
# filepath: d:\Workspace\flutter\fullstack-fashionapp\pybackend\run_azure_server.py
"""
Script để khởi động server ASGI trên máy ảo Azure cho ứng dụng Fashion App Backend.
Script này được thiết kế để chạy ngầm ngay cả khi đóng phiên SSH.
"""

import sys
import subprocess
import time
import os
import signal
import argparse
import logging
from pathlib import Path
import atexit

# Thiết lập logging
logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s - %(name)s - %(levelname)s - %(message)s",
    filename="/tmp/fashion_backend_server.log",  # Đường dẫn log file
    filemode="a",
)
logger = logging.getLogger("azure_server")

# Đường dẫn thư mục hiện tại
CURRENT_DIR = os.path.dirname(os.path.abspath(__file__))
FASHION_BACKEND_DIR = os.path.join(CURRENT_DIR, "fashion_backend")
PID_FILE = "/tmp/fashion_backend_server.pid"  # File lưu PID của process

# Đường dẫn đến các file certificate nếu có
CERT_FILE = os.path.join(FASHION_BACKEND_DIR, "cert.pem")
KEY_FILE = os.path.join(FASHION_BACKEND_DIR, "key.pem")


def collect_static():
    """Thu thập static files."""
    try:
        logger.info("Thu thập static files...")
        result = subprocess.run(
            ["python", "manage.py", "collectstatic", "--noinput"],
            cwd=FASHION_BACKEND_DIR,
            capture_output=True,
            text=True,
        )
        if result.returncode == 0:
            logger.info("Đã thu thập static files thành công.")
            return True
        else:
            logger.error(f"Lỗi khi thu thập static files: {result.stderr}")
            return False
    except Exception as e:
        logger.error(f"Lỗi khi thu thập static files: {e}")
        return False


def start_daphne(daemonize=True, use_ssl=False):
    """Khởi động server Daphne."""
    try:
        logger.info("Đang khởi động server Daphne...")

        # Các options cho Daphne
        daphne_cmd = [
            "daphne",
            "-b",
            "0.0.0.0",
            "-p",
            "8000",
        ]

        # Thêm SSL nếu được yêu cầu và các file certificate tồn tại
        if use_ssl and os.path.exists(CERT_FILE) and os.path.exists(KEY_FILE):
            logger.info("Kích hoạt SSL với certificate đã cung cấp.")
            daphne_cmd.extend(["--ssl-certfile", CERT_FILE, "--ssl-keyfile", KEY_FILE])

        # Thêm application path
        daphne_cmd.append("backend.asgi:application")

        if daemonize:
            # Khởi động Daphne với nohup để chạy ngầm
            with open("/tmp/daphne_output.log", "a") as outfile:
                process = subprocess.Popen(
                    ["nohup"] + daphne_cmd,
                    stdout=outfile,
                    stderr=outfile,
                    cwd=FASHION_BACKEND_DIR,
                    preexec_fn=os.setsid,  # Tạo session mới để tránh bị kill khi đóng terminal
                )
                # Lưu PID vào file
                with open(PID_FILE, "w") as f:
                    f.write(str(process.pid))
        else:
            # Chạy trong foreground (cho testing)
            process = subprocess.Popen(daphne_cmd, cwd=FASHION_BACKEND_DIR)

        logger.info(f"Daphne đã được khởi động với PID {process.pid}")
        return process
    except Exception as e:
        logger.error(f"Lỗi khi khởi động Daphne: {e}")
        return None


def start_uvicorn(daemonize=True, use_ssl=False):
    """Khởi động server Uvicorn."""
    try:
        logger.info("Đang khởi động server Uvicorn...")

        # Các options cho Uvicorn
        uvicorn_cmd = [
            "uvicorn",
            "backend.asgi:application",
            "--host",
            "0.0.0.0",
            "--port",
            "8000",
        ]

        # Thêm SSL nếu được yêu cầu và các file certificate tồn tại
        if use_ssl and os.path.exists(CERT_FILE) and os.path.exists(KEY_FILE):
            logger.info("Kích hoạt SSL với certificate đã cung cấp.")
            uvicorn_cmd.extend(["--ssl-certfile", CERT_FILE, "--ssl-keyfile", KEY_FILE])

        if daemonize:
            # Khởi động Uvicorn với nohup để chạy ngầm
            with open("/tmp/uvicorn_output.log", "a") as outfile:
                process = subprocess.Popen(
                    ["nohup"] + uvicorn_cmd,
                    stdout=outfile,
                    stderr=outfile,
                    cwd=FASHION_BACKEND_DIR,
                    preexec_fn=os.setsid,  # Tạo session mới để tránh bị kill khi đóng terminal
                )
                # Lưu PID vào file
                with open(PID_FILE, "w") as f:
                    f.write(str(process.pid))
        else:
            # Chạy trong foreground (cho testing)
            process = subprocess.Popen(uvicorn_cmd, cwd=FASHION_BACKEND_DIR)

        logger.info(f"Uvicorn đã được khởi động với PID {process.pid}")
        return process
    except Exception as e:
        logger.error(f"Lỗi khi khởi động Uvicorn: {e}")
        return None


def apply_migrations():
    """Áp dụng các migration nếu có."""
    try:
        logger.info("Đang áp dụng migrations...")
        result = subprocess.run(
            ["python", "manage.py", "migrate"],
            cwd=FASHION_BACKEND_DIR,
            capture_output=True,
            text=True,
        )
        if result.returncode == 0:
            logger.info("Đã áp dụng migrations thành công.")
            return True
        else:
            logger.error(f"Lỗi khi áp dụng migrations: {result.stderr}")
            return False
    except Exception as e:
        logger.error(f"Lỗi khi áp dụng migrations: {e}")
        return False


def stop_server():
    """Dừng server đang chạy."""
    try:
        if os.path.exists(PID_FILE):
            with open(PID_FILE, "r") as f:
                pid = int(f.read().strip())

            logger.info(f"Đang dừng server với PID {pid}...")
            try:
                # Gửi signal SIGTERM để thoát gracefully
                os.killpg(os.getpgid(pid), signal.SIGTERM)
                logger.info(f"Đã dừng process với PID {pid}")
            except ProcessLookupError:
                logger.warning(f"Process với PID {pid} không tồn tại")
            except Exception as e:
                logger.error(f"Lỗi khi dừng process: {e}")

            # Xóa file PID
            os.remove(PID_FILE)
            return True
    except Exception as e:
        logger.error(f"Lỗi khi dừng server: {e}")

    return False


def check_status():
    """Kiểm tra trạng thái server."""
    server_running = os.path.exists(PID_FILE)

    if server_running:
        with open(PID_FILE, "r") as f:
            pid = f.read().strip()
        server_status = f"Server đang chạy với PID {pid}"
    else:
        server_status = "Server không chạy"

    return {
        "server": server_status,
    }


def main():
    """Hàm chính để chạy server."""
    parser = argparse.ArgumentParser(
        description="Quản lý ASGI Server trên Azure VM cho Fashion Backend"
    )
    parser.add_argument(
        "--action",
        choices=["start", "stop", "restart", "status"],
        required=True,
        help="Hành động: start, stop, restart, status",
    )
    parser.add_argument(
        "--server",
        choices=["daphne", "uvicorn"],
        default="uvicorn",
        help="ASGI server: daphne hoặc uvicorn (mặc định: uvicorn)",
    )
    parser.add_argument(
        "--foreground",
        action="store_true",
        help="Chạy trong foreground (không daemon hóa)",
    )
    parser.add_argument(
        "--ssl",
        action="store_true",
        help="Kích hoạt SSL sử dụng cert.pem và key.pem trong thư mục fashion_backend",
    )
    parser.add_argument(
        "--skip-migrations",
        action="store_true",
        help="Bỏ qua việc chạy migrations khi khởi động",
    )
    parser.add_argument(
        "--skip-collectstatic",
        action="store_true",
        help="Bỏ qua việc thu thập static files khi khởi động",
    )

    args = parser.parse_args()

    # Xử lý các hành động
    if args.action == "status":
        status = check_status()
        print(f"Server: {status['server']}")
        return

    if args.action == "stop" or args.action == "restart":
        stop_server()
        if args.action == "stop":
            return

    if args.action == "start" or args.action == "restart":
        # Áp dụng migrations nếu không skip
        if not args.skip_migrations:
            apply_migrations()

        # Thu thập static files nếu không skip
        if not args.skip_collectstatic:
            collect_static()

        # Khởi động ASGI server
        server_process = None
        daemonize = not args.foreground
        use_ssl = args.ssl

        if use_ssl:
            if os.path.exists(CERT_FILE) and os.path.exists(KEY_FILE):
                print("Kích hoạt SSL với certificate đã cung cấp.")
            else:
                print(
                    "CẢNH BÁO: Không tìm thấy các file SSL certificate. Server sẽ chạy không có SSL."
                )
                use_ssl = False

        if args.server == "daphne":
            server_process = start_daphne(daemonize, use_ssl)
        else:
            server_process = start_uvicorn(daemonize, use_ssl)

        if not server_process and daemonize:
            logger.error("Không thể khởi động server.")
            print("Không thể khởi động server.")
            return

        protocol = "https" if use_ssl else "http"
        logger.info(f"Server đã khởi động tại {protocol}://0.0.0.0:8000/")
        print(f"Server đã khởi động tại {protocol}://0.0.0.0:8000/")
        print(f"API endpoints có thể truy cập tại {protocol}://0.0.0.0:8000/auth/")
        print(f"Log file: /tmp/fashion_backend_server.log")

        if args.foreground:
            # Trong chế độ foreground, chờ Ctrl+C
            try:
                print("\nNhấn Ctrl+C để dừng server...")
                while True:
                    time.sleep(1)
            except KeyboardInterrupt:
                print("\nĐang dừng server...")
                server_process.terminate()
                server_process.wait()
                print("Server đã dừng.")


if __name__ == "__main__":
    main()
