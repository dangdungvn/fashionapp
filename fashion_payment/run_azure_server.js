// filepath: d:\Workspace\flutter\fullstack-fashionapp\fashion_payment\run_azure_server.js
const { spawn } = require("child_process");
const fs = require("fs");
const path = require("path");

/**
 * Script để chạy server Fashion Payment trên máy ảo Azure.
 * Script này được thiết kế để chạy ngầm ngay cả khi đóng phiên SSH.
 *
 * Cách sử dụng:
 * - Để khởi động: node run_azure_server.js start
 * - Để dừng: node run_azure_server.js stop
 * - Để kiểm tra trạng thái: node run_azure_server.js status
 * - Để xem log: node run_azure_server.js log
 */

// Cấu hình
const CONFIG = {
  pidFile: "/tmp/fashion_payment.pid",
  logFile: "/tmp/fashion_payment.log",
  startCommand: "node",
  startArgs: ["index.js"],
  appName: "Fashion Payment Server",
};

// Đảm bảo đường dẫn thư mục làm việc là thư mục chứa script này
const CURRENT_DIR = __dirname;

/**
 * Ghi log ra file
 */
function log(message) {
  const timestamp = new Date().toISOString();
  const logMessage = `${timestamp} - ${message}\n`;

  // Ghi log vào file
  fs.appendFileSync(CONFIG.logFile, logMessage);

  // Hiển thị log ra console
  console.log(message);
}

/**
 * Khởi động server
 */
function startServer() {
  log(`Đang khởi động ${CONFIG.appName}...`);

  try {
    // Kiểm tra nếu server đã đang chạy
    if (fs.existsSync(CONFIG.pidFile)) {
      const pid = fs.readFileSync(CONFIG.pidFile, "utf-8").trim();
      try {
        // Kiểm tra xem process có tồn tại không
        process.kill(pid, 0);
        log(`${CONFIG.appName} đã đang chạy với PID ${pid}`);
        return;
      } catch (e) {
        // Process không tồn tại, xóa file PID cũ
        log(`Phát hiện file PID cũ không hợp lệ. Xóa và khởi động lại.`);
        fs.unlinkSync(CONFIG.pidFile);
      }
    }

    // Mở file log để ghi output
    const logStream = fs.openSync(CONFIG.logFile, "a");

    // Khởi động server với Node.js và lưu output vào file log
    const server = spawn(CONFIG.startCommand, CONFIG.startArgs, {
      cwd: CURRENT_DIR,
      detached: true, // Cho phép chạy độc lập với terminal
      stdio: ["ignore", logStream, logStream], // Chuyển hướng output ra file log
    });

    // Tách process con ra khỏi process cha để có thể chạy ngầm
    server.unref();

    // Lưu PID vào file
    fs.writeFileSync(CONFIG.pidFile, server.pid.toString());

    log(`${CONFIG.appName} đã được khởi động với PID ${server.pid}`);
    log(`Server đang chạy tại http://0.0.0.0:${process.env.PORT || 3003}/`);
    log(`Log file: ${CONFIG.logFile}`);
  } catch (error) {
    log(`Lỗi khi khởi động server: ${error.message}`);
  }
}

/**
 * Dừng server
 */
function stopServer() {
  log(`Đang dừng ${CONFIG.appName}...`);

  try {
    // Kiểm tra nếu file PID tồn tại
    if (fs.existsSync(CONFIG.pidFile)) {
      const pid = fs.readFileSync(CONFIG.pidFile, "utf-8").trim();

      try {
        // Gửi tín hiệu SIGTERM để dừng process
        process.kill(pid, "SIGTERM");
        log(`Đã gửi tín hiệu dừng đến process PID ${pid}`);

        // Xóa file PID
        fs.unlinkSync(CONFIG.pidFile);
      } catch (e) {
        log(`Không tìm thấy process với PID ${pid}. Server có thể đã dừng.`);

        // Xóa file PID nếu còn
        if (fs.existsSync(CONFIG.pidFile)) {
          fs.unlinkSync(CONFIG.pidFile);
        }
      }
    } else {
      log(`Server không chạy (không tìm thấy file PID)`);
    }
  } catch (error) {
    log(`Lỗi khi dừng server: ${error.message}`);
  }
}

/**
 * Kiểm tra trạng thái server
 */
function checkStatus() {
  try {
    // Kiểm tra xem file PID có tồn tại không
    if (fs.existsSync(CONFIG.pidFile)) {
      const pid = fs.readFileSync(CONFIG.pidFile, "utf-8").trim();

      try {
        // Kiểm tra xem process có đang chạy không
        process.kill(pid, 0);
        console.log(`${CONFIG.appName} đang chạy với PID ${pid}`);
        console.log(`Log file: ${CONFIG.logFile}`);
      } catch (e) {
        console.log(
          `${CONFIG.appName} không chạy (process không tồn tại nhưng file PID còn)`
        );
        // Xóa file PID cũ
        fs.unlinkSync(CONFIG.pidFile);
      }
    } else {
      console.log(`${CONFIG.appName} không chạy (không tìm thấy file PID)`);
    }
  } catch (error) {
    console.log(`Lỗi khi kiểm tra trạng thái: ${error.message}`);
  }
}

/**
 * Đọc file log
 */
function showLog(numberOfLines = 50) {
  try {
    if (fs.existsSync(CONFIG.logFile)) {
      // Đọc file log và hiển thị số dòng cuối
      const { execSync } = require("child_process");
      const output = execSync(`tail -n ${numberOfLines} ${CONFIG.logFile}`);
      console.log(`${numberOfLines} dòng cuối của log file ${CONFIG.logFile}:`);
      console.log(output.toString());
    } else {
      console.log(`File log ${CONFIG.logFile} không tồn tại.`);
    }
  } catch (error) {
    console.log(`Lỗi khi đọc log: ${error.message}`);
  }
}

// Xử lý tham số dòng lệnh
const action = process.argv[2];

switch (action) {
  case "start":
    startServer();
    break;

  case "stop":
    stopServer();
    break;

  case "restart":
    stopServer();
    // Chờ một chút để đảm bảo server đã dừng
    setTimeout(() => {
      startServer();
    }, 2000);
    break;

  case "status":
    checkStatus();
    break;

  case "log":
    const lines = process.argv[3] ? parseInt(process.argv[3], 10) : 50;
    showLog(lines);
    break;

  default:
    console.log(
      "Sử dụng: node run_azure_server.js [start|stop|restart|status|log [số dòng]]"
    );
    break;
}
