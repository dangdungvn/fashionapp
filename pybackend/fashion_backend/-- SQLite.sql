-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th1 13, 2025 lúc 03:15 PM
-- Phiên bản máy phục vụ: 10.4.32-MariaDB
-- Phiên bản PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `utt_qlkh`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `core_admins`
--

CREATE TABLE `core_admins` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `core_permission_action`
--

CREATE TABLE `core_permission_action` (
  `id` int(10) UNSIGNED NOT NULL,
  `action` text NOT NULL,
  `controller_type` varchar(255) NOT NULL,
  `permission_name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `core_permission_group`
--

CREATE TABLE `core_permission_group` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `permission_names` text NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `utt_files`
--

CREATE TABLE `utt_files` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL COMMENT 'Ten file',
  `ref_id` int(10) UNSIGNED NOT NULL COMMENT 'ID cua QD hoac De tai...',
  `level` int(10) UNSIGNED NOT NULL COMMENT 'Phan loai theo cap: DTCS, DT cap bo, nha nuoc...',
  `type` int(11) NOT NULL COMMENT 'Loai tep dinh kem: QD giao nhiem vu|Thuyet minh|...',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `utt_science_uni_form`
--

CREATE TABLE `utt_science_uni_form` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `code` varchar(255) DEFAULT NULL COMMENT 'Ma so de tai',
  `proposal_code` varchar(255) DEFAULT NULL,
  `research_area_id` int(11) NOT NULL DEFAULT 0 COMMENT 'ID Linh vuc nghien cuu',
  `research_type` int(11) NOT NULL DEFAULT 0 COMMENT 'Loai hinh nghien cuu',
  `title` text NOT NULL COMMENT 'Ten de tai',
  `tinh_cap_thiet` text DEFAULT NULL COMMENT 'Tinh cap thiet cua de tai',
  `target` text DEFAULT NULL COMMENT 'Muc tieu cua de tai',
  `result` text DEFAULT NULL COMMENT 'Ket qua cua de tai',
  `main_content` text DEFAULT NULL COMMENT 'Noi dung chinh cua de tai',
  `teacher_info_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT 'ID cua giang vien - utt_teacher_info table',
  `teacher_relate_ids` text DEFAULT NULL COMMENT 'List ID giang vien tham gia',
  `student_info_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT 'ID cua sinh vien - utt_student_info table',
  `student_relate_ids` text DEFAULT NULL COMMENT 'List ID sinh vien tham gia',
  `deadline_from` date DEFAULT NULL COMMENT 'Thoi gian bat dau thuc hien',
  `deadline_to` date DEFAULT NULL COMMENT 'Thoi gian ket thuc thuc hien',
  `estimate_time` varchar(255) DEFAULT NULL COMMENT 'Thoi gian thuc hien',
  `doituong_phamvi` text DEFAULT NULL COMMENT 'Doi tuong, pham vi nghien cuu',
  `tong_quan` text DEFAULT NULL COMMENT 'Tong quan tinh hinh nghien cuu',
  `phuong_phap_nghien_cuu` text DEFAULT NULL COMMENT 'Cach tiep can, phuong phap nghien cuu',
  `contents` text DEFAULT NULL COMMENT 'Noi dung nghien cuu',
  `note` text DEFAULT NULL COMMENT 'Ghi chu',
  `uni_level_accepted` int(11) NOT NULL DEFAULT 0 COMMENT 'Trang thai phe duyet cap Truong | True/Fasle',
  `completed_status` int(11) NOT NULL DEFAULT 0 COMMENT 'Trang thai hoan thanh de tai | True/Fasle',
  `decision_task_id` int(11) DEFAULT 0 COMMENT 'ID Quyet dinh giao nhiem vu',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `utt_teacher_bckh`
--

CREATE TABLE `utt_teacher_bckh` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uid` int(11) NOT NULL,
  `loaibaocao` varchar(255) NOT NULL,
  `thutu` int(11) NOT NULL,
  `tenbaibao` varchar(255) NOT NULL,
  `tentapchi` varchar(255) NOT NULL,
  `trang` varchar(255) NOT NULL,
  `thoigian` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `utt_teacher_info`
--

CREATE TABLE `utt_teacher_info` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `macanbo` varchar(255) DEFAULT NULL,
  `hovaten` varchar(255) NOT NULL,
  `gioitinh` int(11) NOT NULL,
  `namsinh` varchar(255) NOT NULL,
  `namtotnghiep` varchar(255) DEFAULT NULL,
  `hocvi` varchar(255) DEFAULT NULL,
  `hocham` varchar(255) DEFAULT NULL,
  `chucdanh` varchar(255) DEFAULT '',
  `namphonghocham` varchar(255) DEFAULT NULL,
  `chucvu` varchar(255) DEFAULT NULL,
  `llct` varchar(255) DEFAULT NULL,
  `mangach` varchar(255) DEFAULT NULL,
  `department_id` int(11) DEFAULT NULL,
  `dtnharieng` varchar(255) DEFAULT NULL,
  `dtdidong` varchar(255) DEFAULT NULL,
  `dtcoquan` varchar(255) DEFAULT NULL,
  `fax` varchar(255) DEFAULT NULL,
  `diachi` text DEFAULT NULL,
  `status` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE `utt_student_info` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `masinhvien` varchar(255) DEFAULT NULL,
  `hovaten` varchar(255) NOT NULL,
  `gioitinh` int(11) NOT NULL,
  `namsinh` varchar(255) NOT NULL,
  `department_id` int(11) DEFAULT NULL,
  `dtnharieng` varchar(255) DEFAULT NULL,
  `dtdidong` varchar(255) DEFAULT NULL,
  `fax` varchar(255) DEFAULT NULL,
  `diachi` text DEFAULT NULL,
  `status` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `utt_uni_research_area`
--

CREATE TABLE `utt_uni_research_area` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL COMMENT 'Ten linh vuc nghien cuu',
  `status` int(11) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `utt_web_notifications`
--

CREATE TABLE `utt_web_notifications` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `content` text NOT NULL COMMENT 'Content of notification',
  `type` varchar(255) NOT NULL,
  `seen` tinyint(1) NOT NULL DEFAULT 0,
  `seen_date` datetime DEFAULT NULL,
  `meta_data` text DEFAULT NULL COMMENT 'Additional data saved in json format',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `model_has_permissions`
--

CREATE TABLE `model_has_permissions` (
  `permission_id` bigint(20) UNSIGNED NOT NULL,
  `model_type` varchar(255) NOT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `model_has_roles`
--

CREATE TABLE `model_has_roles` (
  `role_id` bigint(20) UNSIGNED NOT NULL,
  `model_type` varchar(255) NOT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `permissions`
--

CREATE TABLE `permissions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `guard_name` varchar(255) NOT NULL,
  `label` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `roles`
--

CREATE TABLE `roles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `guard_name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `role_has_permissions`
--

CREATE TABLE `role_has_permissions` (
  `permission_id` bigint(20) UNSIGNED NOT NULL,
  `role_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `status` int(11) NOT NULL DEFAULT 1,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `core_admins`
--
ALTER TABLE `core_admins`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `core_admins_email_unique` (`email`);

--
-- Chỉ mục cho bảng `core_permission_action`
--
ALTER TABLE `core_permission_action`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `core_permission_action_permission_name_unique` (`permission_name`);

--
-- Chỉ mục cho bảng `core_permission_group`
--
ALTER TABLE `core_permission_group`
  ADD PRIMARY KEY (`id`);


--
-- Chỉ mục cho bảng `utt_files`
--
ALTER TABLE `utt_files`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `utt_science_uni_form`
--
ALTER TABLE `utt_science_uni_form`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `utt_science_uni_form_code_unique` (`code`);

--
-- Chỉ mục cho bảng `utt_teacher_bckh`
--
ALTER TABLE `utt_teacher_bckh`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `utt_teacher_info`
--
ALTER TABLE `utt_teacher_info`
  ADD PRIMARY KEY (`id`),
  ADD KEY `utt_teacher_info_user_id_foreign` (`user_id`);
--
-- Chỉ mục cho bảng `utt_uni_research_area`
--
ALTER TABLE `utt_uni_research_area`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `utt_web_notifications`
--
ALTER TABLE `utt_web_notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `utt_web_notifications_user_id_foreign` (`user_id`);

--
-- Chỉ mục cho bảng `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`model_id`,`model_type`),
  ADD KEY `model_has_permissions_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Chỉ mục cho bảng `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  ADD KEY `model_has_roles_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Chỉ mục cho bảng `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Chỉ mục cho bảng `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `permissions_name_guard_name_unique` (`name`,`guard_name`);

--
-- Chỉ mục cho bảng `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Chỉ mục cho bảng `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `roles_name_guard_name_unique` (`name`,`guard_name`);

--
-- Chỉ mục cho bảng `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`role_id`),
  ADD KEY `role_has_permissions_role_id_foreign` (`role_id`);

--
-- Chỉ mục cho bảng `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `core_admins`
--
ALTER TABLE `core_admins`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `core_permission_action`
--
ALTER TABLE `core_permission_action`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `core_permission_group`
--
ALTER TABLE `core_permission_group`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `utt_files`
--
ALTER TABLE `utt_files`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `utt_science_uni_form`
--
ALTER TABLE `utt_science_uni_form`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `utt_teacher_bckh`
--
ALTER TABLE `utt_teacher_bckh`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `utt_teacher_info`
--
ALTER TABLE `utt_teacher_info`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT cho bảng `utt_uni_research_area`
--
ALTER TABLE `utt_uni_research_area`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `utt_web_notifications`
--
ALTER TABLE `utt_web_notifications`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `utt_teacher_info`
--
ALTER TABLE `utt_teacher_info`
  ADD CONSTRAINT `utt_teacher_info_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Các ràng buộc cho bảng `utt_web_notifications`
--
ALTER TABLE `utt_web_notifications`
  ADD CONSTRAINT `utt_web_notifications_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Các ràng buộc cho bảng `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD CONSTRAINT `model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
