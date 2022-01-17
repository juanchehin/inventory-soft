-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         5.7.31 - MySQL Community Server (GPL)
-- SO del servidor:              Win64
-- HeidiSQL Versión:             11.2.0.6213
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Volcando estructura de base de datos para inventory
CREATE DATABASE IF NOT EXISTS `inventory` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */;
USE `inventory`;

-- Volcando estructura para tabla inventory.accounts
CREATE TABLE IF NOT EXISTS `accounts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `business_id` int(11) NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `account_number` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `account_type` enum('saving_current','capital') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `note` text COLLATE utf8mb4_unicode_ci,
  `created_by` int(11) NOT NULL,
  `is_closed` tinyint(1) NOT NULL DEFAULT '0',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla inventory.accounts: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `accounts` DISABLE KEYS */;
/*!40000 ALTER TABLE `accounts` ENABLE KEYS */;

-- Volcando estructura para tabla inventory.account_transactions
CREATE TABLE IF NOT EXISTS `account_transactions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL,
  `type` enum('debit','credit') COLLATE utf8mb4_unicode_ci NOT NULL,
  `sub_type` enum('opening_balance','fund_transfer','deposit') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `amount` decimal(22,4) NOT NULL,
  `reff_no` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `operation_date` datetime NOT NULL,
  `created_by` int(11) NOT NULL,
  `transaction_id` int(11) DEFAULT NULL,
  `transaction_payment_id` int(11) DEFAULT NULL,
  `transfer_transaction_id` int(11) DEFAULT NULL,
  `note` text COLLATE utf8mb4_unicode_ci,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `account_transactions_account_id_index` (`account_id`),
  KEY `account_transactions_transaction_id_index` (`transaction_id`),
  KEY `account_transactions_transaction_payment_id_index` (`transaction_payment_id`),
  KEY `account_transactions_transfer_transaction_id_index` (`transfer_transaction_id`),
  KEY `account_transactions_created_by_index` (`created_by`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla inventory.account_transactions: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `account_transactions` DISABLE KEYS */;
/*!40000 ALTER TABLE `account_transactions` ENABLE KEYS */;

-- Volcando estructura para tabla inventory.activity_log
CREATE TABLE IF NOT EXISTS `activity_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `log_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `subject_id` int(11) DEFAULT NULL,
  `subject_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `causer_id` int(11) DEFAULT NULL,
  `causer_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `properties` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `activity_log_log_name_index` (`log_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla inventory.activity_log: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `activity_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `activity_log` ENABLE KEYS */;

-- Volcando estructura para tabla inventory.barcodes
CREATE TABLE IF NOT EXISTS `barcodes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `width` double(8,2) DEFAULT NULL,
  `height` double(8,2) DEFAULT NULL,
  `paper_width` double(8,2) DEFAULT NULL,
  `paper_height` double(8,2) DEFAULT NULL,
  `top_margin` double(8,2) DEFAULT NULL,
  `left_margin` double(8,2) DEFAULT NULL,
  `row_distance` double(8,2) DEFAULT NULL,
  `col_distance` double(8,2) DEFAULT NULL,
  `stickers_in_one_row` int(11) DEFAULT NULL,
  `is_default` tinyint(1) NOT NULL DEFAULT '0',
  `is_continuous` tinyint(1) NOT NULL DEFAULT '0',
  `stickers_in_one_sheet` int(11) DEFAULT NULL,
  `business_id` int(10) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `barcodes_business_id_foreign` (`business_id`),
  CONSTRAINT `barcodes_business_id_foreign` FOREIGN KEY (`business_id`) REFERENCES `business` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla inventory.barcodes: ~6 rows (aproximadamente)
/*!40000 ALTER TABLE `barcodes` DISABLE KEYS */;
INSERT INTO `barcodes` (`id`, `name`, `description`, `width`, `height`, `paper_width`, `paper_height`, `top_margin`, `left_margin`, `row_distance`, `col_distance`, `stickers_in_one_row`, `is_default`, `is_continuous`, `stickers_in_one_sheet`, `business_id`, `created_at`, `updated_at`) VALUES
	(1, '20 Labels per Sheet - (8.5" x 11")', 'Sheet Size: 8.5" x 11"\\r\\nLabel Size: 4" x 1"\\r\\nLabels per sheet: 20', 3.75, 1.00, 8.50, 11.00, 0.50, 0.50, 0.00, 0.16, 2, 0, 0, 20, NULL, '2017-12-18 06:13:44', '2017-12-18 06:13:44'),
	(2, '30 Labels per sheet - (8.5" x 11")', 'Sheet Size: 8.5" x 11"\\r\\nLabel Size: 2.625" x 1"\\r\\nLabels per sheet: 30', 2.62, 1.00, 8.50, 11.00, 0.50, 0.22, 0.00, 0.14, 3, 0, 0, 30, NULL, '2017-12-18 06:04:39', '2017-12-18 06:10:40'),
	(3, '32 Labels per sheet - (8.5" x 11")', 'Sheet Size: 8.5" x 11"\\r\\nLabel Size: 2" x 1.25"\\r\\nLabels per sheet: 32', 2.00, 1.25, 8.50, 11.00, 0.50, 0.25, 0.00, 0.00, 4, 0, 0, 32, NULL, '2017-12-18 05:55:40', '2017-12-18 05:55:40'),
	(4, '40 Labels per sheet - (8.5" x 11")', 'Sheet Size: 8.5" x 11"\\r\\nLabel Size: 2" x 1"\\r\\nLabels per sheet: 40', 2.00, 1.00, 8.50, 11.00, 0.50, 0.25, 0.00, 0.00, 4, 0, 0, 40, NULL, '2017-12-18 05:58:40', '2017-12-18 05:58:40'),
	(5, '50 Labels per Sheet - (8.5" x 11")', 'Sheet Size: 8.5" x 11"\\r\\nLabel Size: 1.5" x 1"\\r\\nLabels per sheet: 50', 1.50, 1.00, 8.50, 11.00, 0.50, 0.50, 0.00, 0.00, 5, 0, 0, 50, NULL, '2017-12-18 05:51:10', '2017-12-18 05:51:10'),
	(6, 'Continuous Rolls - 31.75mm x 25.4mm', 'Label Size: 31.75mm x 25.4mm\\r\\nGap: 3.18mm', 1.25, 1.00, 1.25, 0.00, 0.12, 0.00, 0.12, 0.00, 1, 0, 1, NULL, NULL, '2017-12-18 05:51:10', '2017-12-18 05:51:10');
/*!40000 ALTER TABLE `barcodes` ENABLE KEYS */;

-- Volcando estructura para tabla inventory.bookings
CREATE TABLE IF NOT EXISTS `bookings` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `contact_id` int(10) unsigned NOT NULL,
  `waiter_id` int(10) unsigned DEFAULT NULL,
  `table_id` int(10) unsigned DEFAULT NULL,
  `correspondent_id` int(11) DEFAULT NULL,
  `business_id` int(10) unsigned NOT NULL,
  `location_id` int(10) unsigned NOT NULL,
  `booking_start` datetime NOT NULL,
  `booking_end` datetime NOT NULL,
  `created_by` int(10) unsigned NOT NULL,
  `booking_status` enum('booked','completed','cancelled') COLLATE utf8mb4_unicode_ci NOT NULL,
  `booking_note` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `bookings_contact_id_foreign` (`contact_id`),
  KEY `bookings_business_id_foreign` (`business_id`),
  KEY `bookings_created_by_foreign` (`created_by`),
  KEY `bookings_table_id_index` (`table_id`),
  KEY `bookings_waiter_id_index` (`waiter_id`),
  KEY `bookings_location_id_index` (`location_id`),
  CONSTRAINT `bookings_business_id_foreign` FOREIGN KEY (`business_id`) REFERENCES `business` (`id`) ON DELETE CASCADE,
  CONSTRAINT `bookings_contact_id_foreign` FOREIGN KEY (`contact_id`) REFERENCES `contacts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `bookings_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla inventory.bookings: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `bookings` DISABLE KEYS */;
/*!40000 ALTER TABLE `bookings` ENABLE KEYS */;

-- Volcando estructura para tabla inventory.brands
CREATE TABLE IF NOT EXISTS `brands` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `business_id` int(10) unsigned NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `created_by` int(10) unsigned NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `brands_business_id_foreign` (`business_id`),
  KEY `brands_created_by_foreign` (`created_by`),
  CONSTRAINT `brands_business_id_foreign` FOREIGN KEY (`business_id`) REFERENCES `business` (`id`) ON DELETE CASCADE,
  CONSTRAINT `brands_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla inventory.brands: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `brands` DISABLE KEYS */;
/*!40000 ALTER TABLE `brands` ENABLE KEYS */;

-- Volcando estructura para tabla inventory.business
CREATE TABLE IF NOT EXISTS `business` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(256) COLLATE utf8mb4_unicode_ci NOT NULL,
  `currency_id` int(10) unsigned NOT NULL,
  `start_date` date DEFAULT NULL,
  `tax_number_1` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tax_label_1` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tax_number_2` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tax_label_2` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `default_sales_tax` int(10) unsigned DEFAULT NULL,
  `default_profit_percent` double(5,2) NOT NULL DEFAULT '0.00',
  `owner_id` int(10) unsigned NOT NULL,
  `time_zone` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Asia/Kolkata',
  `fy_start_month` tinyint(4) NOT NULL DEFAULT '1',
  `accounting_method` enum('fifo','lifo','avco') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'fifo',
  `default_sales_discount` decimal(20,2) DEFAULT NULL,
  `sell_price_tax` enum('includes','excludes') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'includes',
  `logo` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sku_prefix` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `enable_product_expiry` tinyint(1) NOT NULL DEFAULT '0',
  `expiry_type` enum('add_expiry','add_manufacturing') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'add_expiry',
  `on_product_expiry` enum('keep_selling','stop_selling','auto_delete') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'keep_selling',
  `stop_selling_before` int(11) NOT NULL COMMENT 'Stop selling expied item n days before expiry',
  `enable_tooltip` tinyint(1) NOT NULL DEFAULT '1',
  `purchase_in_diff_currency` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Allow purchase to be in different currency then the business currency',
  `purchase_currency_id` int(10) unsigned DEFAULT NULL,
  `p_exchange_rate` decimal(20,3) NOT NULL DEFAULT '1.000',
  `transaction_edit_days` int(10) unsigned NOT NULL DEFAULT '30',
  `stock_expiry_alert_days` int(10) unsigned NOT NULL DEFAULT '30',
  `keyboard_shortcuts` text COLLATE utf8mb4_unicode_ci,
  `pos_settings` text COLLATE utf8mb4_unicode_ci,
  `enable_brand` tinyint(1) NOT NULL DEFAULT '1',
  `enable_category` tinyint(1) NOT NULL DEFAULT '1',
  `enable_sub_category` tinyint(1) NOT NULL DEFAULT '1',
  `enable_price_tax` tinyint(1) NOT NULL DEFAULT '1',
  `enable_purchase_status` tinyint(1) DEFAULT '1',
  `enable_lot_number` tinyint(1) NOT NULL DEFAULT '0',
  `default_unit` int(11) DEFAULT NULL,
  `enable_racks` tinyint(1) NOT NULL DEFAULT '0',
  `enable_row` tinyint(1) NOT NULL DEFAULT '0',
  `enable_position` tinyint(1) NOT NULL DEFAULT '0',
  `enable_editing_product_from_purchase` tinyint(1) NOT NULL DEFAULT '1',
  `sales_cmsn_agnt` enum('logged_in_user','user','cmsn_agnt') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `item_addition_method` tinyint(1) NOT NULL DEFAULT '1',
  `enable_inline_tax` tinyint(1) NOT NULL DEFAULT '1',
  `currency_symbol_placement` enum('before','after') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'before',
  `enabled_modules` text COLLATE utf8mb4_unicode_ci,
  `date_format` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'm/d/Y',
  `time_format` enum('12','24') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '24',
  `ref_no_prefixes` text COLLATE utf8mb4_unicode_ci,
  `theme_color` char(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `email_settings` text COLLATE utf8mb4_unicode_ci,
  `sms_settings` text COLLATE utf8mb4_unicode_ci,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `business_owner_id_foreign` (`owner_id`),
  KEY `business_currency_id_foreign` (`currency_id`),
  KEY `business_default_sales_tax_foreign` (`default_sales_tax`),
  CONSTRAINT `business_currency_id_foreign` FOREIGN KEY (`currency_id`) REFERENCES `currencies` (`id`),
  CONSTRAINT `business_default_sales_tax_foreign` FOREIGN KEY (`default_sales_tax`) REFERENCES `tax_rates` (`id`),
  CONSTRAINT `business_owner_id_foreign` FOREIGN KEY (`owner_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla inventory.business: ~3 rows (aproximadamente)
/*!40000 ALTER TABLE `business` DISABLE KEYS */;
INSERT INTO `business` (`id`, `name`, `currency_id`, `start_date`, `tax_number_1`, `tax_label_1`, `tax_number_2`, `tax_label_2`, `default_sales_tax`, `default_profit_percent`, `owner_id`, `time_zone`, `fy_start_month`, `accounting_method`, `default_sales_discount`, `sell_price_tax`, `logo`, `sku_prefix`, `enable_product_expiry`, `expiry_type`, `on_product_expiry`, `stop_selling_before`, `enable_tooltip`, `purchase_in_diff_currency`, `purchase_currency_id`, `p_exchange_rate`, `transaction_edit_days`, `stock_expiry_alert_days`, `keyboard_shortcuts`, `pos_settings`, `enable_brand`, `enable_category`, `enable_sub_category`, `enable_price_tax`, `enable_purchase_status`, `enable_lot_number`, `default_unit`, `enable_racks`, `enable_row`, `enable_position`, `enable_editing_product_from_purchase`, `sales_cmsn_agnt`, `item_addition_method`, `enable_inline_tax`, `currency_symbol_placement`, `enabled_modules`, `date_format`, `time_format`, `ref_no_prefixes`, `theme_color`, `created_by`, `email_settings`, `sms_settings`, `is_active`, `created_at`, `updated_at`) VALUES
	(1, 'sgmtucuman', 4, NULL, NULL, NULL, NULL, NULL, NULL, 25.00, 1, 'America/Argentina/Buenos_Aires', 1, 'fifo', NULL, 'includes', '1642375534_facebook.png', NULL, 0, 'add_expiry', 'keep_selling', 0, 1, 0, NULL, 1.000, 30, 30, '{"pos":{"express_checkout":"shift+e","pay_n_ckeckout":"shift+p","draft":"shift+d","cancel":"shift+c","edit_discount":"shift+i","edit_order_tax":"shift+t","add_payment_row":"shift+r","finalize_payment":"shift+f","recent_product_quantity":"f2","add_new_product":"f4"}}', NULL, 1, 1, 1, 1, 1, 0, NULL, 0, 0, 0, 1, NULL, 1, 0, 'before', NULL, 'm/d/Y', '24', '{"purchase":"PO","stock_transfer":"ST","stock_adjustment":"SA","sell_return":"CN","expense":"EP","contacts":"CO","purchase_payment":"PP","sell_payment":"SP","business_location":"BL"}', NULL, NULL, NULL, NULL, 1, '2022-01-17 04:55:35', '2022-01-17 04:55:35'),
	(2, 'sgmtucuman', 3, NULL, NULL, NULL, NULL, NULL, NULL, 25.00, 2, 'America/Argentina/Buenos_Aires', 1, 'fifo', NULL, 'includes', '1642433671_twitter.png', NULL, 0, 'add_expiry', 'keep_selling', 0, 1, 0, NULL, 1.000, 30, 30, '{"pos":{"express_checkout":"shift+e","pay_n_ckeckout":"shift+p","draft":"shift+d","cancel":"shift+c","edit_discount":"shift+i","edit_order_tax":"shift+t","add_payment_row":"shift+r","finalize_payment":"shift+f","recent_product_quantity":"f2","add_new_product":"f4"}}', NULL, 1, 1, 1, 1, 1, 0, NULL, 0, 0, 0, 1, NULL, 1, 0, 'before', NULL, 'm/d/Y', '24', '{"purchase":"PO","stock_transfer":"ST","stock_adjustment":"SA","sell_return":"CN","expense":"EP","contacts":"CO","purchase_payment":"PP","sell_payment":"SP","business_location":"BL"}', NULL, NULL, NULL, NULL, 1, '2022-01-17 21:04:31', '2022-01-17 21:04:31'),
	(3, 'Slider', 4, NULL, NULL, NULL, NULL, NULL, NULL, 25.00, 3, 'America/Argentina/Tucuman', 1, 'fifo', NULL, 'includes', '1642445771_instagram.png', NULL, 0, 'add_expiry', 'keep_selling', 0, 1, 0, NULL, 1.000, 30, 30, '{"pos":{"express_checkout":"shift+e","pay_n_ckeckout":"shift+p","draft":"shift+d","cancel":"shift+c","edit_discount":"shift+i","edit_order_tax":"shift+t","add_payment_row":"shift+r","finalize_payment":"shift+f","recent_product_quantity":"f2","add_new_product":"f4"}}', NULL, 1, 1, 1, 1, 1, 0, NULL, 0, 0, 0, 1, NULL, 1, 0, 'before', NULL, 'm/d/Y', '24', '{"purchase":"PO","stock_transfer":"ST","stock_adjustment":"SA","sell_return":"CN","expense":"EP","contacts":"CO","purchase_payment":"PP","sell_payment":"SP","business_location":"BL"}', NULL, NULL, NULL, NULL, 1, '2022-01-18 00:26:11', '2022-01-18 00:26:11');
/*!40000 ALTER TABLE `business` ENABLE KEYS */;

-- Volcando estructura para tabla inventory.business_locations
CREATE TABLE IF NOT EXISTS `business_locations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `business_id` int(10) unsigned NOT NULL,
  `location_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(256) COLLATE utf8mb4_unicode_ci NOT NULL,
  `landmark` text COLLATE utf8mb4_unicode_ci,
  `country` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `state` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `city` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `zip_code` char(7) COLLATE utf8mb4_unicode_ci NOT NULL,
  `invoice_scheme_id` int(10) unsigned NOT NULL,
  `invoice_layout_id` int(10) unsigned NOT NULL,
  `print_receipt_on_invoice` tinyint(1) DEFAULT '1',
  `receipt_printer_type` enum('browser','printer') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'browser',
  `printer_id` int(11) DEFAULT NULL,
  `mobile` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `alternate_number` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `website` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `custom_field1` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `custom_field2` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `custom_field3` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `custom_field4` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `business_locations_business_id_index` (`business_id`),
  KEY `business_locations_invoice_scheme_id_foreign` (`invoice_scheme_id`),
  KEY `business_locations_invoice_layout_id_foreign` (`invoice_layout_id`),
  CONSTRAINT `business_locations_business_id_foreign` FOREIGN KEY (`business_id`) REFERENCES `business` (`id`) ON DELETE CASCADE,
  CONSTRAINT `business_locations_invoice_layout_id_foreign` FOREIGN KEY (`invoice_layout_id`) REFERENCES `invoice_layouts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `business_locations_invoice_scheme_id_foreign` FOREIGN KEY (`invoice_scheme_id`) REFERENCES `invoice_schemes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla inventory.business_locations: ~3 rows (aproximadamente)
/*!40000 ALTER TABLE `business_locations` DISABLE KEYS */;
INSERT INTO `business_locations` (`id`, `business_id`, `location_id`, `name`, `landmark`, `country`, `state`, `city`, `zip_code`, `invoice_scheme_id`, `invoice_layout_id`, `print_receipt_on_invoice`, `receipt_printer_type`, `printer_id`, `mobile`, `alternate_number`, `email`, `website`, `custom_field1`, `custom_field2`, `custom_field3`, `custom_field4`, `deleted_at`, `created_at`, `updated_at`) VALUES
	(1, 1, 'BL0001', 'sgmtucuman', 'Tucuman', 'Argentina', 'Tucuman', 'Tucuman', '4000', 1, 1, 1, 'browser', NULL, '', '', '', '', NULL, NULL, NULL, NULL, NULL, '2022-01-17 04:55:35', '2022-01-17 04:55:35'),
	(2, 2, 'BL0001', 'sgmtucuman', '4000', 'Argentina', 'Tucuman', 'San miguel', '4000', 2, 2, 1, 'browser', NULL, '', '', '', '', NULL, NULL, NULL, NULL, NULL, '2022-01-17 21:04:31', '2022-01-17 21:04:31'),
	(3, 3, 'BL0001', 'Slider', 'Tucuman', 'Argentina', 'Tucuman', 'Tucuan', '4000', 3, 3, 1, 'browser', NULL, '', '', '', '', NULL, NULL, NULL, NULL, NULL, '2022-01-18 00:26:12', '2022-01-18 00:26:12');
/*!40000 ALTER TABLE `business_locations` ENABLE KEYS */;

-- Volcando estructura para tabla inventory.cash_registers
CREATE TABLE IF NOT EXISTS `cash_registers` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `business_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned DEFAULT NULL,
  `status` enum('close','open') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'open',
  `closed_at` datetime DEFAULT NULL,
  `closing_amount` decimal(20,2) NOT NULL DEFAULT '0.00',
  `total_card_slips` int(11) NOT NULL DEFAULT '0',
  `total_cheques` int(11) NOT NULL DEFAULT '0',
  `closing_note` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cash_registers_business_id_foreign` (`business_id`),
  KEY `cash_registers_user_id_foreign` (`user_id`),
  CONSTRAINT `cash_registers_business_id_foreign` FOREIGN KEY (`business_id`) REFERENCES `business` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cash_registers_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla inventory.cash_registers: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `cash_registers` DISABLE KEYS */;
/*!40000 ALTER TABLE `cash_registers` ENABLE KEYS */;

-- Volcando estructura para tabla inventory.cash_register_transactions
CREATE TABLE IF NOT EXISTS `cash_register_transactions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `cash_register_id` int(10) unsigned NOT NULL,
  `amount` decimal(20,2) NOT NULL DEFAULT '0.00',
  `pay_method` enum('cash','card','cheque','bank_transfer','custom_pay_1','custom_pay_2','custom_pay_3','other') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` enum('debit','credit') COLLATE utf8mb4_unicode_ci NOT NULL,
  `transaction_type` enum('initial','sell','transfer','refund') COLLATE utf8mb4_unicode_ci NOT NULL,
  `transaction_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cash_register_transactions_cash_register_id_foreign` (`cash_register_id`),
  KEY `cash_register_transactions_transaction_id_index` (`transaction_id`),
  CONSTRAINT `cash_register_transactions_cash_register_id_foreign` FOREIGN KEY (`cash_register_id`) REFERENCES `cash_registers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla inventory.cash_register_transactions: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `cash_register_transactions` DISABLE KEYS */;
/*!40000 ALTER TABLE `cash_register_transactions` ENABLE KEYS */;

-- Volcando estructura para tabla inventory.categories
CREATE TABLE IF NOT EXISTS `categories` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `business_id` int(10) unsigned NOT NULL,
  `short_code` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parent_id` int(11) NOT NULL,
  `created_by` int(10) unsigned NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `categories_business_id_foreign` (`business_id`),
  KEY `categories_created_by_foreign` (`created_by`),
  CONSTRAINT `categories_business_id_foreign` FOREIGN KEY (`business_id`) REFERENCES `business` (`id`) ON DELETE CASCADE,
  CONSTRAINT `categories_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla inventory.categories: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;

-- Volcando estructura para tabla inventory.contacts
CREATE TABLE IF NOT EXISTS `contacts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `business_id` int(10) unsigned NOT NULL,
  `type` enum('supplier','customer','both') COLLATE utf8mb4_unicode_ci NOT NULL,
  `supplier_business_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tax_number` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `city` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `state` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `landmark` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mobile` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `landline` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `alternate_number` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pay_term_number` int(11) DEFAULT NULL,
  `pay_term_type` enum('days','months') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `credit_limit` decimal(20,2) DEFAULT NULL,
  `created_by` int(10) unsigned NOT NULL,
  `is_default` tinyint(1) NOT NULL DEFAULT '0',
  `customer_group_id` int(11) DEFAULT NULL,
  `custom_field1` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `custom_field2` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `custom_field3` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `custom_field4` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `contacts_business_id_foreign` (`business_id`),
  KEY `contacts_created_by_foreign` (`created_by`),
  CONSTRAINT `contacts_business_id_foreign` FOREIGN KEY (`business_id`) REFERENCES `business` (`id`) ON DELETE CASCADE,
  CONSTRAINT `contacts_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla inventory.contacts: ~3 rows (aproximadamente)
/*!40000 ALTER TABLE `contacts` DISABLE KEYS */;
INSERT INTO `contacts` (`id`, `business_id`, `type`, `supplier_business_name`, `name`, `email`, `contact_id`, `tax_number`, `city`, `state`, `country`, `landmark`, `mobile`, `landline`, `alternate_number`, `pay_term_number`, `pay_term_type`, `credit_limit`, `created_by`, `is_default`, `customer_group_id`, `custom_field1`, `custom_field2`, `custom_field3`, `custom_field4`, `deleted_at`, `created_at`, `updated_at`) VALUES
	(1, 1, 'customer', NULL, 'Walk-In Customer', NULL, 'CO0001', NULL, NULL, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2022-01-17 04:55:35', '2022-01-17 04:55:35'),
	(2, 2, 'customer', NULL, 'Walk-In Customer', NULL, 'CO0001', NULL, NULL, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, 2, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2022-01-17 21:04:31', '2022-01-17 21:04:31'),
	(3, 3, 'customer', NULL, 'Walk-In Customer', NULL, 'CO0001', NULL, NULL, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, 3, 1, NULL, NULL, NULL, NULL, NULL, NULL, '2022-01-18 00:26:12', '2022-01-18 00:26:12');
/*!40000 ALTER TABLE `contacts` ENABLE KEYS */;

-- Volcando estructura para tabla inventory.currencies
CREATE TABLE IF NOT EXISTS `currencies` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `country` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `currency` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(25) COLLATE utf8mb4_unicode_ci NOT NULL,
  `symbol` varchar(25) COLLATE utf8mb4_unicode_ci NOT NULL,
  `thousand_separator` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `decimal_separator` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=139 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla inventory.currencies: ~138 rows (aproximadamente)
/*!40000 ALTER TABLE `currencies` DISABLE KEYS */;
INSERT INTO `currencies` (`id`, `country`, `currency`, `code`, `symbol`, `thousand_separator`, `decimal_separator`, `created_at`, `updated_at`) VALUES
	(1, 'Albania', 'Leke', 'ALL', 'Lek', ',', '.', NULL, NULL),
	(2, 'America', 'Dollars', 'USD', '$', ',', '.', NULL, NULL),
	(3, 'Afghanistan', 'Afghanis', 'AF', '؋', ',', '.', NULL, NULL),
	(4, 'Argentina', 'Pesos', 'ARS', '$', ',', '.', NULL, NULL),
	(5, 'Aruba', 'Guilders', 'AWG', 'ƒ', ',', '.', NULL, NULL),
	(6, 'Australia', 'Dollars', 'AUD', '$', ',', '.', NULL, NULL),
	(7, 'Azerbaijan', 'New Manats', 'AZ', 'ман', ',', '.', NULL, NULL),
	(8, 'Bahamas', 'Dollars', 'BSD', '$', ',', '.', NULL, NULL),
	(9, 'Barbados', 'Dollars', 'BBD', '$', ',', '.', NULL, NULL),
	(10, 'Belarus', 'Rubles', 'BYR', 'p.', ',', '.', NULL, NULL),
	(11, 'Belgium', 'Euro', 'EUR', '€', ',', '.', NULL, NULL),
	(12, 'Beliz', 'Dollars', 'BZD', 'BZ$', ',', '.', NULL, NULL),
	(13, 'Bermuda', 'Dollars', 'BMD', '$', ',', '.', NULL, NULL),
	(14, 'Bolivia', 'Bolivianos', 'BOB', '$b', ',', '.', NULL, NULL),
	(15, 'Bosnia and Herzegovina', 'Convertible Marka', 'BAM', 'KM', ',', '.', NULL, NULL),
	(16, 'Botswana', 'Pula\'s', 'BWP', 'P', ',', '.', NULL, NULL),
	(17, 'Bulgaria', 'Leva', 'BG', 'лв', ',', '.', NULL, NULL),
	(18, 'Brazil', 'Reais', 'BRL', 'R$', ',', '.', NULL, NULL),
	(19, 'Britain [United Kingdom]', 'Pounds', 'GBP', '£', ',', '.', NULL, NULL),
	(20, 'Brunei Darussalam', 'Dollars', 'BND', '$', ',', '.', NULL, NULL),
	(21, 'Cambodia', 'Riels', 'KHR', '៛', ',', '.', NULL, NULL),
	(22, 'Canada', 'Dollars', 'CAD', '$', ',', '.', NULL, NULL),
	(23, 'Cayman Islands', 'Dollars', 'KYD', '$', ',', '.', NULL, NULL),
	(24, 'Chile', 'Pesos', 'CLP', '$', ',', '.', NULL, NULL),
	(25, 'China', 'Yuan Renminbi', 'CNY', '¥', ',', '.', NULL, NULL),
	(26, 'Colombia', 'Pesos', 'COP', '$', ',', '.', NULL, NULL),
	(27, 'Costa Rica', 'Colón', 'CRC', '₡', ',', '.', NULL, NULL),
	(28, 'Croatia', 'Kuna', 'HRK', 'kn', ',', '.', NULL, NULL),
	(29, 'Cuba', 'Pesos', 'CUP', '₱', ',', '.', NULL, NULL),
	(30, 'Cyprus', 'Euro', 'EUR', '€', '.', ',', NULL, NULL),
	(31, 'Czech Republic', 'Koruny', 'CZK', 'Kč', ',', '.', NULL, NULL),
	(32, 'Denmark', 'Kroner', 'DKK', 'kr', ',', '.', NULL, NULL),
	(33, 'Dominican Republic', 'Pesos', 'DOP ', 'RD$', ',', '.', NULL, NULL),
	(34, 'East Caribbean', 'Dollars', 'XCD', '$', ',', '.', NULL, NULL),
	(35, 'Egypt', 'Pounds', 'EGP', '£', ',', '.', NULL, NULL),
	(36, 'El Salvador', 'Colones', 'SVC', '$', ',', '.', NULL, NULL),
	(37, 'England [United Kingdom]', 'Pounds', 'GBP', '£', ',', '.', NULL, NULL),
	(38, 'Euro', 'Euro', 'EUR', '€', '.', ',', NULL, NULL),
	(39, 'Falkland Islands', 'Pounds', 'FKP', '£', ',', '.', NULL, NULL),
	(40, 'Fiji', 'Dollars', 'FJD', '$', ',', '.', NULL, NULL),
	(41, 'France', 'Euro', 'EUR', '€', '.', ',', NULL, NULL),
	(42, 'Ghana', 'Cedis', 'GHC', '¢', ',', '.', NULL, NULL),
	(43, 'Gibraltar', 'Pounds', 'GIP', '£', ',', '.', NULL, NULL),
	(44, 'Greece', 'Euro', 'EUR', '€', '.', ',', NULL, NULL),
	(45, 'Guatemala', 'Quetzales', 'GTQ', 'Q', ',', '.', NULL, NULL),
	(46, 'Guernsey', 'Pounds', 'GGP', '£', ',', '.', NULL, NULL),
	(47, 'Guyana', 'Dollars', 'GYD', '$', ',', '.', NULL, NULL),
	(48, 'Holland [Netherlands]', 'Euro', 'EUR', '€', '.', ',', NULL, NULL),
	(49, 'Honduras', 'Lempiras', 'HNL', 'L', ',', '.', NULL, NULL),
	(50, 'Hong Kong', 'Dollars', 'HKD', '$', ',', '.', NULL, NULL),
	(51, 'Hungary', 'Forint', 'HUF', 'Ft', ',', '.', NULL, NULL),
	(52, 'Iceland', 'Kronur', 'ISK', 'kr', ',', '.', NULL, NULL),
	(53, 'India', 'Rupees', 'INR', '₹', ',', '.', NULL, NULL),
	(54, 'Indonesia', 'Rupiahs', 'IDR', 'Rp', ',', '.', NULL, NULL),
	(55, 'Iran', 'Rials', 'IRR', '﷼', ',', '.', NULL, NULL),
	(56, 'Ireland', 'Euro', 'EUR', '€', '.', ',', NULL, NULL),
	(57, 'Isle of Man', 'Pounds', 'IMP', '£', ',', '.', NULL, NULL),
	(58, 'Israel', 'New Shekels', 'ILS', '₪', ',', '.', NULL, NULL),
	(59, 'Italy', 'Euro', 'EUR', '€', '.', ',', NULL, NULL),
	(60, 'Jamaica', 'Dollars', 'JMD', 'J$', ',', '.', NULL, NULL),
	(61, 'Japan', 'Yen', 'JPY', '¥', ',', '.', NULL, NULL),
	(62, 'Jersey', 'Pounds', 'JEP', '£', ',', '.', NULL, NULL),
	(63, 'Kazakhstan', 'Tenge', 'KZT', 'лв', ',', '.', NULL, NULL),
	(64, 'Korea [North]', 'Won', 'KPW', '₩', ',', '.', NULL, NULL),
	(65, 'Korea [South]', 'Won', 'KRW', '₩', ',', '.', NULL, NULL),
	(66, 'Kyrgyzstan', 'Soms', 'KGS', 'лв', ',', '.', NULL, NULL),
	(67, 'Laos', 'Kips', 'LAK', '₭', ',', '.', NULL, NULL),
	(68, 'Latvia', 'Lati', 'LVL', 'Ls', ',', '.', NULL, NULL),
	(69, 'Lebanon', 'Pounds', 'LBP', '£', ',', '.', NULL, NULL),
	(70, 'Liberia', 'Dollars', 'LRD', '$', ',', '.', NULL, NULL),
	(71, 'Liechtenstein', 'Switzerland Francs', 'CHF', 'CHF', ',', '.', NULL, NULL),
	(72, 'Lithuania', 'Litai', 'LTL', 'Lt', ',', '.', NULL, NULL),
	(73, 'Luxembourg', 'Euro', 'EUR', '€', '.', ',', NULL, NULL),
	(74, 'Macedonia', 'Denars', 'MKD', 'ден', ',', '.', NULL, NULL),
	(75, 'Malaysia', 'Ringgits', 'MYR', 'RM', ',', '.', NULL, NULL),
	(76, 'Malta', 'Euro', 'EUR', '€', '.', ',', NULL, NULL),
	(77, 'Mauritius', 'Rupees', 'MUR', '₨', ',', '.', NULL, NULL),
	(78, 'Mexico', 'Pesos', 'MX', '$', ',', '.', NULL, NULL),
	(79, 'Mongolia', 'Tugriks', 'MNT', '₮', ',', '.', NULL, NULL),
	(80, 'Mozambique', 'Meticais', 'MZ', 'MT', ',', '.', NULL, NULL),
	(81, 'Namibia', 'Dollars', 'NAD', '$', ',', '.', NULL, NULL),
	(82, 'Nepal', 'Rupees', 'NPR', '₨', ',', '.', NULL, NULL),
	(83, 'Netherlands Antilles', 'Guilders', 'ANG', 'ƒ', ',', '.', NULL, NULL),
	(84, 'Netherlands', 'Euro', 'EUR', '€', '.', ',', NULL, NULL),
	(85, 'New Zealand', 'Dollars', 'NZD', '$', ',', '.', NULL, NULL),
	(86, 'Nicaragua', 'Cordobas', 'NIO', 'C$', ',', '.', NULL, NULL),
	(87, 'Nigeria', 'Nairas', 'NG', '₦', ',', '.', NULL, NULL),
	(88, 'North Korea', 'Won', 'KPW', '₩', ',', '.', NULL, NULL),
	(89, 'Norway', 'Krone', 'NOK', 'kr', ',', '.', NULL, NULL),
	(90, 'Oman', 'Rials', 'OMR', '﷼', ',', '.', NULL, NULL),
	(91, 'Pakistan', 'Rupees', 'PKR', '₨', ',', '.', NULL, NULL),
	(92, 'Panama', 'Balboa', 'PAB', 'B/.', ',', '.', NULL, NULL),
	(93, 'Paraguay', 'Guarani', 'PYG', 'Gs', ',', '.', NULL, NULL),
	(94, 'Peru', 'Nuevos Soles', 'PE', 'S/.', ',', '.', NULL, NULL),
	(95, 'Philippines', 'Pesos', 'PHP', 'Php', ',', '.', NULL, NULL),
	(96, 'Poland', 'Zlotych', 'PL', 'zł', ',', '.', NULL, NULL),
	(97, 'Qatar', 'Rials', 'QAR', '﷼', ',', '.', NULL, NULL),
	(98, 'Romania', 'New Lei', 'RO', 'lei', ',', '.', NULL, NULL),
	(99, 'Russia', 'Rubles', 'RUB', 'руб', ',', '.', NULL, NULL),
	(100, 'Saint Helena', 'Pounds', 'SHP', '£', ',', '.', NULL, NULL),
	(101, 'Saudi Arabia', 'Riyals', 'SAR', '﷼', ',', '.', NULL, NULL),
	(102, 'Serbia', 'Dinars', 'RSD', 'Дин.', ',', '.', NULL, NULL),
	(103, 'Seychelles', 'Rupees', 'SCR', '₨', ',', '.', NULL, NULL),
	(104, 'Singapore', 'Dollars', 'SGD', '$', ',', '.', NULL, NULL),
	(105, 'Slovenia', 'Euro', 'EUR', '€', '.', ',', NULL, NULL),
	(106, 'Solomon Islands', 'Dollars', 'SBD', '$', ',', '.', NULL, NULL),
	(107, 'Somalia', 'Shillings', 'SOS', 'S', ',', '.', NULL, NULL),
	(108, 'South Africa', 'Rand', 'ZAR', 'R', ',', '.', NULL, NULL),
	(109, 'South Korea', 'Won', 'KRW', '₩', ',', '.', NULL, NULL),
	(110, 'Spain', 'Euro', 'EUR', '€', '.', ',', NULL, NULL),
	(111, 'Sri Lanka', 'Rupees', 'LKR', '₨', ',', '.', NULL, NULL),
	(112, 'Sweden', 'Kronor', 'SEK', 'kr', ',', '.', NULL, NULL),
	(113, 'Switzerland', 'Francs', 'CHF', 'CHF', ',', '.', NULL, NULL),
	(114, 'Suriname', 'Dollars', 'SRD', '$', ',', '.', NULL, NULL),
	(115, 'Syria', 'Pounds', 'SYP', '£', ',', '.', NULL, NULL),
	(116, 'Taiwan', 'New Dollars', 'TWD', 'NT$', ',', '.', NULL, NULL),
	(117, 'Thailand', 'Baht', 'THB', '฿', ',', '.', NULL, NULL),
	(118, 'Trinidad and Tobago', 'Dollars', 'TTD', 'TT$', ',', '.', NULL, NULL),
	(119, 'Turkey', 'Lira', 'TRY', 'TL', ',', '.', NULL, NULL),
	(120, 'Turkey', 'Liras', 'TRL', '£', ',', '.', NULL, NULL),
	(121, 'Tuvalu', 'Dollars', 'TVD', '$', ',', '.', NULL, NULL),
	(122, 'Ukraine', 'Hryvnia', 'UAH', '₴', ',', '.', NULL, NULL),
	(123, 'United Kingdom', 'Pounds', 'GBP', '£', ',', '.', NULL, NULL),
	(124, 'United States of America', 'Dollars', 'USD', '$', ',', '.', NULL, NULL),
	(125, 'Uruguay', 'Pesos', 'UYU', '$U', ',', '.', NULL, NULL),
	(126, 'Uzbekistan', 'Sums', 'UZS', 'лв', ',', '.', NULL, NULL),
	(127, 'Vatican City', 'Euro', 'EUR', '€', '.', ',', NULL, NULL),
	(128, 'Venezuela', 'Bolivares Fuertes', 'VEF', 'Bs', ',', '.', NULL, NULL),
	(129, 'Vietnam', 'Dong', 'VND', '₫', ',', '.', NULL, NULL),
	(130, 'Yemen', 'Rials', 'YER', '﷼', ',', '.', NULL, NULL),
	(131, 'Zimbabwe', 'Zimbabwe Dollars', 'ZWD', 'Z$', ',', '.', NULL, NULL),
	(132, 'Iraq', 'Iraqi dinar', 'IQD', 'د.ع', ',', '.', NULL, NULL),
	(133, 'Kenya', 'Kenyan shilling', 'KES', 'KSh', ',', '.', NULL, NULL),
	(134, 'Bangladesh', 'Taka', 'BDT', '৳', ',', '.', NULL, NULL),
	(135, 'Algerie', 'Algerian dinar', 'DZD', 'د.ج', ' ', '.', NULL, NULL),
	(136, 'United Arab Emirates', 'United Arab Emirates dirham', 'AED', 'د.إ', ',', '.', NULL, NULL),
	(137, 'Uganda', 'Uganda shillings', 'UGX', 'USh', ',', '.', NULL, NULL),
	(138, 'Tanzania', 'Tanzanian shilling', 'TZS', 'TSh', ',', '.', NULL, NULL);
/*!40000 ALTER TABLE `currencies` ENABLE KEYS */;

-- Volcando estructura para tabla inventory.customer_groups
CREATE TABLE IF NOT EXISTS `customer_groups` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `business_id` int(10) unsigned NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` double(5,2) NOT NULL,
  `created_by` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `customer_groups_business_id_foreign` (`business_id`),
  CONSTRAINT `customer_groups_business_id_foreign` FOREIGN KEY (`business_id`) REFERENCES `business` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla inventory.customer_groups: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `customer_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `customer_groups` ENABLE KEYS */;

-- Volcando estructura para tabla inventory.discounts
CREATE TABLE IF NOT EXISTS `discounts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `business_id` int(11) NOT NULL,
  `brand_id` int(11) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `location_id` int(11) DEFAULT NULL,
  `priority` int(11) DEFAULT NULL,
  `discount_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `discount_amount` decimal(20,2) NOT NULL DEFAULT '0.00',
  `starts_at` datetime DEFAULT NULL,
  `ends_at` datetime DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `applicable_in_spg` tinyint(1) DEFAULT '0',
  `applicable_in_cg` tinyint(1) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `discounts_business_id_index` (`business_id`),
  KEY `discounts_brand_id_index` (`brand_id`),
  KEY `discounts_category_id_index` (`category_id`),
  KEY `discounts_location_id_index` (`location_id`),
  KEY `discounts_priority_index` (`priority`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla inventory.discounts: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `discounts` DISABLE KEYS */;
/*!40000 ALTER TABLE `discounts` ENABLE KEYS */;

-- Volcando estructura para tabla inventory.expense_categories
CREATE TABLE IF NOT EXISTS `expense_categories` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `business_id` int(10) unsigned NOT NULL,
  `code` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `expense_categories_business_id_foreign` (`business_id`),
  CONSTRAINT `expense_categories_business_id_foreign` FOREIGN KEY (`business_id`) REFERENCES `business` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla inventory.expense_categories: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `expense_categories` DISABLE KEYS */;
/*!40000 ALTER TABLE `expense_categories` ENABLE KEYS */;

-- Volcando estructura para tabla inventory.group_sub_taxes
CREATE TABLE IF NOT EXISTS `group_sub_taxes` (
  `group_tax_id` int(10) unsigned NOT NULL,
  `tax_id` int(10) unsigned NOT NULL,
  KEY `group_sub_taxes_group_tax_id_foreign` (`group_tax_id`),
  KEY `group_sub_taxes_tax_id_foreign` (`tax_id`),
  CONSTRAINT `group_sub_taxes_group_tax_id_foreign` FOREIGN KEY (`group_tax_id`) REFERENCES `tax_rates` (`id`) ON DELETE CASCADE,
  CONSTRAINT `group_sub_taxes_tax_id_foreign` FOREIGN KEY (`tax_id`) REFERENCES `tax_rates` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla inventory.group_sub_taxes: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `group_sub_taxes` DISABLE KEYS */;
/*!40000 ALTER TABLE `group_sub_taxes` ENABLE KEYS */;

-- Volcando estructura para tabla inventory.invoice_layouts
CREATE TABLE IF NOT EXISTS `invoice_layouts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `header_text` text COLLATE utf8mb4_unicode_ci,
  `invoice_no_prefix` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `quotation_no_prefix` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `invoice_heading` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sub_heading_line1` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sub_heading_line2` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sub_heading_line3` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sub_heading_line4` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sub_heading_line5` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `invoice_heading_not_paid` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `invoice_heading_paid` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `quotation_heading` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sub_total_label` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `discount_label` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tax_label` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total_label` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total_due_label` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `paid_label` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `show_client_id` tinyint(1) NOT NULL DEFAULT '0',
  `client_id_label` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `client_tax_label` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_label` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_time_format` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `show_time` tinyint(1) NOT NULL DEFAULT '1',
  `show_brand` tinyint(1) NOT NULL DEFAULT '0',
  `show_sku` tinyint(1) NOT NULL DEFAULT '1',
  `show_cat_code` tinyint(1) NOT NULL DEFAULT '1',
  `show_expiry` tinyint(1) NOT NULL DEFAULT '0',
  `show_lot` tinyint(1) NOT NULL DEFAULT '0',
  `show_image` tinyint(1) NOT NULL DEFAULT '0',
  `show_sale_description` tinyint(1) NOT NULL DEFAULT '0',
  `sales_person_label` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `show_sales_person` tinyint(1) NOT NULL DEFAULT '0',
  `table_product_label` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `table_qty_label` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `table_unit_price_label` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `table_subtotal_label` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cat_code_label` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `logo` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `show_logo` tinyint(1) NOT NULL DEFAULT '0',
  `show_business_name` tinyint(1) NOT NULL DEFAULT '0',
  `show_location_name` tinyint(1) NOT NULL DEFAULT '1',
  `show_landmark` tinyint(1) NOT NULL DEFAULT '1',
  `show_city` tinyint(1) NOT NULL DEFAULT '1',
  `show_state` tinyint(1) NOT NULL DEFAULT '1',
  `show_zip_code` tinyint(1) NOT NULL DEFAULT '1',
  `show_country` tinyint(1) NOT NULL DEFAULT '1',
  `show_mobile_number` tinyint(1) NOT NULL DEFAULT '1',
  `show_alternate_number` tinyint(1) NOT NULL DEFAULT '0',
  `show_email` tinyint(1) NOT NULL DEFAULT '0',
  `show_tax_1` tinyint(1) NOT NULL DEFAULT '1',
  `show_tax_2` tinyint(1) NOT NULL DEFAULT '0',
  `show_barcode` tinyint(1) NOT NULL DEFAULT '0',
  `show_payments` tinyint(1) NOT NULL DEFAULT '0',
  `show_customer` tinyint(1) NOT NULL DEFAULT '0',
  `customer_label` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `highlight_color` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `footer_text` text COLLATE utf8mb4_unicode_ci,
  `module_info` text COLLATE utf8mb4_unicode_ci,
  `is_default` tinyint(1) NOT NULL DEFAULT '0',
  `business_id` int(10) unsigned NOT NULL,
  `design` varchar(256) COLLATE utf8mb4_unicode_ci DEFAULT 'classic',
  `cn_heading` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'cn = credit note',
  `cn_no_label` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cn_amount_label` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `table_tax_headings` text COLLATE utf8mb4_unicode_ci,
  `show_previous_bal` tinyint(1) NOT NULL DEFAULT '0',
  `prev_bal_label` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `product_custom_fields` text COLLATE utf8mb4_unicode_ci,
  `contact_custom_fields` text COLLATE utf8mb4_unicode_ci,
  `location_custom_fields` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `invoice_layouts_business_id_foreign` (`business_id`),
  CONSTRAINT `invoice_layouts_business_id_foreign` FOREIGN KEY (`business_id`) REFERENCES `business` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla inventory.invoice_layouts: ~3 rows (aproximadamente)
/*!40000 ALTER TABLE `invoice_layouts` DISABLE KEYS */;
INSERT INTO `invoice_layouts` (`id`, `name`, `header_text`, `invoice_no_prefix`, `quotation_no_prefix`, `invoice_heading`, `sub_heading_line1`, `sub_heading_line2`, `sub_heading_line3`, `sub_heading_line4`, `sub_heading_line5`, `invoice_heading_not_paid`, `invoice_heading_paid`, `quotation_heading`, `sub_total_label`, `discount_label`, `tax_label`, `total_label`, `total_due_label`, `paid_label`, `show_client_id`, `client_id_label`, `client_tax_label`, `date_label`, `date_time_format`, `show_time`, `show_brand`, `show_sku`, `show_cat_code`, `show_expiry`, `show_lot`, `show_image`, `show_sale_description`, `sales_person_label`, `show_sales_person`, `table_product_label`, `table_qty_label`, `table_unit_price_label`, `table_subtotal_label`, `cat_code_label`, `logo`, `show_logo`, `show_business_name`, `show_location_name`, `show_landmark`, `show_city`, `show_state`, `show_zip_code`, `show_country`, `show_mobile_number`, `show_alternate_number`, `show_email`, `show_tax_1`, `show_tax_2`, `show_barcode`, `show_payments`, `show_customer`, `customer_label`, `highlight_color`, `footer_text`, `module_info`, `is_default`, `business_id`, `design`, `cn_heading`, `cn_no_label`, `cn_amount_label`, `table_tax_headings`, `show_previous_bal`, `prev_bal_label`, `product_custom_fields`, `contact_custom_fields`, `location_custom_fields`, `created_at`, `updated_at`) VALUES
	(1, 'Default', NULL, 'Invoice No.', NULL, 'Invoice', NULL, NULL, NULL, NULL, NULL, '', '', NULL, 'Subtotal', 'Discount', 'Tax', 'Total', 'Total Due', 'Total Paid', 0, NULL, NULL, 'Date', NULL, 1, 0, 1, 1, 0, 0, 0, 0, NULL, 0, 'Product', 'Quantity', 'Unit Price', 'Subtotal', NULL, NULL, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 0, 0, 1, 1, 'Customer', '#000000', '', NULL, 1, 1, 'classic', NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, '2022-01-17 04:55:35', '2022-01-17 04:55:35'),
	(2, 'Default', NULL, 'Invoice No.', NULL, 'Invoice', NULL, NULL, NULL, NULL, NULL, '', '', NULL, 'Subtotal', 'Discount', 'Tax', 'Total', 'Total Due', 'Total Paid', 0, NULL, NULL, 'Date', NULL, 1, 0, 1, 1, 0, 0, 0, 0, NULL, 0, 'Product', 'Quantity', 'Unit Price', 'Subtotal', NULL, NULL, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 0, 0, 1, 1, 'Customer', '#000000', '', NULL, 1, 2, 'classic', NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, '2022-01-17 21:04:31', '2022-01-17 21:04:31'),
	(3, 'Default', NULL, 'Invoice No.', NULL, 'Invoice', NULL, NULL, NULL, NULL, NULL, '', '', NULL, 'Subtotal', 'Discount', 'Tax', 'Total', 'Total Due', 'Total Paid', 0, NULL, NULL, 'Date', NULL, 1, 0, 1, 1, 0, 0, 0, 0, NULL, 0, 'Product', 'Quantity', 'Unit Price', 'Subtotal', NULL, NULL, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 0, 0, 1, 1, 'Customer', '#000000', '', NULL, 1, 3, 'classic', NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, '2022-01-18 00:26:12', '2022-01-18 00:26:12');
/*!40000 ALTER TABLE `invoice_layouts` ENABLE KEYS */;

-- Volcando estructura para tabla inventory.invoice_schemes
CREATE TABLE IF NOT EXISTS `invoice_schemes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `business_id` int(10) unsigned NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `scheme_type` enum('blank','year') COLLATE utf8mb4_unicode_ci NOT NULL,
  `prefix` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `start_number` int(11) DEFAULT NULL,
  `invoice_count` int(11) NOT NULL DEFAULT '0',
  `total_digits` int(11) DEFAULT NULL,
  `is_default` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `invoice_schemes_business_id_foreign` (`business_id`),
  CONSTRAINT `invoice_schemes_business_id_foreign` FOREIGN KEY (`business_id`) REFERENCES `business` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla inventory.invoice_schemes: ~3 rows (aproximadamente)
/*!40000 ALTER TABLE `invoice_schemes` DISABLE KEYS */;
INSERT INTO `invoice_schemes` (`id`, `business_id`, `name`, `scheme_type`, `prefix`, `start_number`, `invoice_count`, `total_digits`, `is_default`, `created_at`, `updated_at`) VALUES
	(1, 1, 'Default', 'blank', '', 1, 0, 4, 1, '2022-01-17 04:55:35', '2022-01-17 04:55:35'),
	(2, 2, 'Default', 'blank', '', 1, 0, 4, 1, '2022-01-17 21:04:31', '2022-01-17 21:04:31'),
	(3, 3, 'Default', 'blank', '', 1, 0, 4, 1, '2022-01-18 00:26:12', '2022-01-18 00:26:12');
/*!40000 ALTER TABLE `invoice_schemes` ENABLE KEYS */;

-- Volcando estructura para tabla inventory.media
CREATE TABLE IF NOT EXISTS `media` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `business_id` int(11) NOT NULL,
  `file_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` int(10) unsigned NOT NULL,
  `model_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `media_model_id_model_type_index` (`model_id`,`model_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla inventory.media: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `media` DISABLE KEYS */;
/*!40000 ALTER TABLE `media` ENABLE KEYS */;

-- Volcando estructura para tabla inventory.migrations
CREATE TABLE IF NOT EXISTS `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=183 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla inventory.migrations: ~182 rows (aproximadamente)
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
	(1, '2014_10_12_000000_create_users_table', 1),
	(2, '2014_10_12_100000_create_password_resets_table', 1),
	(3, '2017_07_05_071953_create_currencies_table', 1),
	(4, '2017_07_05_073658_create_business_table', 1),
	(5, '2017_07_22_075923_add_business_id_users_table', 1),
	(6, '2017_07_23_113209_create_brands_table', 1),
	(7, '2017_07_26_083429_create_permission_tables', 1),
	(8, '2017_07_26_110000_create_tax_rates_table', 1),
	(9, '2017_07_26_122313_create_units_table', 1),
	(10, '2017_07_27_075706_create_contacts_table', 1),
	(11, '2017_08_04_071038_create_categories_table', 1),
	(12, '2017_08_08_115903_create_products_table', 1),
	(13, '2017_08_09_061616_create_variation_templates_table', 1),
	(14, '2017_08_09_061638_create_variation_value_templates_table', 1),
	(15, '2017_08_10_061146_create_product_variations_table', 1),
	(16, '2017_08_10_061216_create_variations_table', 1),
	(17, '2017_08_19_054827_create_transactions_table', 1),
	(18, '2017_08_31_073533_create_purchase_lines_table', 1),
	(19, '2017_10_15_064638_create_transaction_payments_table', 1),
	(20, '2017_10_31_065621_add_default_sales_tax_to_business_table', 1),
	(21, '2017_11_20_051930_create_table_group_sub_taxes', 1),
	(22, '2017_11_20_063603_create_transaction_sell_lines', 1),
	(23, '2017_11_21_064540_create_barcodes_table', 1),
	(24, '2017_11_23_181237_create_invoice_schemes_table', 1),
	(25, '2017_12_25_122822_create_business_locations_table', 1),
	(26, '2017_12_25_160253_add_location_id_to_transactions_table', 1),
	(27, '2017_12_25_163227_create_variation_location_details_table', 1),
	(28, '2018_01_04_115627_create_sessions_table', 1),
	(29, '2018_01_05_112817_create_invoice_layouts_table', 1),
	(30, '2018_01_06_112303_add_invoice_scheme_id_and_invoice_layout_id_to_business_locations', 1),
	(31, '2018_01_08_104124_create_expense_categories_table', 1),
	(32, '2018_01_08_123327_modify_transactions_table_for_expenses', 1),
	(33, '2018_01_09_111005_modify_payment_status_in_transactions_table', 1),
	(34, '2018_01_09_111109_add_paid_on_column_to_transaction_payments_table', 1),
	(35, '2018_01_25_172439_add_printer_related_fields_to_business_locations_table', 1),
	(36, '2018_01_27_184322_create_printers_table', 1),
	(37, '2018_01_30_181442_create_cash_registers_table', 1),
	(38, '2018_01_31_125836_create_cash_register_transactions_table', 1),
	(39, '2018_02_07_173326_modify_business_table', 1),
	(40, '2018_02_08_105425_add_enable_product_expiry_column_to_business_table', 1),
	(41, '2018_02_08_111027_add_expiry_period_and_expiry_period_type_columns_to_products_table', 1),
	(42, '2018_02_08_131118_add_mfg_date_and_exp_date_purchase_lines_table', 1),
	(43, '2018_02_08_155348_add_exchange_rate_to_transactions_table', 1),
	(44, '2018_02_09_124945_modify_transaction_payments_table_for_contact_payments', 1),
	(45, '2018_02_12_113640_create_transaction_sell_lines_purchase_lines_table', 1),
	(46, '2018_02_12_114605_add_quantity_sold_in_purchase_lines_table', 1),
	(47, '2018_02_13_183323_alter_decimal_fields_size', 1),
	(48, '2018_02_14_161928_add_transaction_edit_days_to_business_table', 1),
	(49, '2018_02_15_161032_add_document_column_to_transactions_table', 1),
	(50, '2018_02_17_124709_add_more_options_to_invoice_layouts', 1),
	(51, '2018_02_19_111517_add_keyboard_shortcut_column_to_business_table', 1),
	(52, '2018_02_19_121537_stock_adjustment_move_to_transaction_table', 1),
	(53, '2018_02_20_165505_add_is_direct_sale_column_to_transactions_table', 1),
	(54, '2018_02_21_105329_create_system_table', 1),
	(55, '2018_02_23_100549_version_1_2', 1),
	(56, '2018_02_23_125648_add_enable_editing_sp_from_purchase_column_to_business_table', 1),
	(57, '2018_02_26_103612_add_sales_commission_agent_column_to_business_table', 1),
	(58, '2018_02_26_130519_modify_users_table_for_sales_cmmsn_agnt', 1),
	(59, '2018_02_26_134500_add_commission_agent_to_transactions_table', 1),
	(60, '2018_02_27_121422_add_item_addition_method_to_business_table', 1),
	(61, '2018_02_27_170232_modify_transactions_table_for_stock_transfer', 1),
	(62, '2018_03_05_153510_add_enable_inline_tax_column_to_business_table', 1),
	(63, '2018_03_06_210206_modify_product_barcode_types', 1),
	(64, '2018_03_13_181541_add_expiry_type_to_business_table', 1),
	(65, '2018_03_16_113446_product_expiry_setting_for_business', 1),
	(66, '2018_03_19_113601_add_business_settings_options', 1),
	(67, '2018_03_26_125334_add_pos_settings_to_business_table', 1),
	(68, '2018_03_26_165350_create_customer_groups_table', 1),
	(69, '2018_03_27_122720_customer_group_related_changes_in_tables', 1),
	(70, '2018_03_29_110138_change_tax_field_to_nullable_in_business_table', 1),
	(71, '2018_03_29_115502_add_changes_for_sr_number_in_products_and_sale_lines_table', 1),
	(72, '2018_03_29_134340_add_inline_discount_fields_in_purchase_lines', 1),
	(73, '2018_03_31_140921_update_transactions_table_exchange_rate', 1),
	(74, '2018_04_03_103037_add_contact_id_to_contacts_table', 1),
	(75, '2018_04_03_122709_add_changes_to_invoice_layouts_table', 1),
	(76, '2018_04_09_135320_change_exchage_rate_size_in_business_table', 1),
	(77, '2018_04_17_123122_add_lot_number_to_business', 1),
	(78, '2018_04_17_160845_add_product_racks_table', 1),
	(79, '2018_04_20_182015_create_res_tables_table', 1),
	(80, '2018_04_24_105246_restaurant_fields_in_transaction_table', 1),
	(81, '2018_04_24_114149_add_enabled_modules_business_table', 1),
	(82, '2018_04_24_133704_add_modules_fields_in_invoice_layout_table', 1),
	(83, '2018_04_27_132653_quotation_related_change', 1),
	(84, '2018_05_02_104439_add_date_format_and_time_format_to_business', 1),
	(85, '2018_05_02_111939_add_sell_return_to_transaction_payments', 1),
	(86, '2018_05_14_114027_add_rows_positions_for_products', 1),
	(87, '2018_05_14_125223_add_weight_to_products_table', 1),
	(88, '2018_05_14_164754_add_opening_stock_permission', 1),
	(89, '2018_05_15_134729_add_design_to_invoice_layouts', 1),
	(90, '2018_05_16_183307_add_tax_fields_invoice_layout', 1),
	(91, '2018_05_18_191956_add_sell_return_to_transaction_table', 1),
	(92, '2018_05_21_131349_add_custom_fileds_to_contacts_table', 1),
	(93, '2018_05_21_131607_invoice_layout_fields_for_sell_return', 1),
	(94, '2018_05_21_131949_add_custom_fileds_and_website_to_business_locations_table', 1),
	(95, '2018_05_22_123527_create_reference_counts_table', 1),
	(96, '2018_05_22_154540_add_ref_no_prefixes_column_to_business_table', 1),
	(97, '2018_05_24_132620_add_ref_no_column_to_transaction_payments_table', 1),
	(98, '2018_05_24_161026_add_location_id_column_to_business_location_table', 1),
	(99, '2018_05_25_180603_create_modifiers_related_table', 1),
	(100, '2018_05_29_121714_add_purchase_line_id_to_stock_adjustment_line_table', 1),
	(101, '2018_05_31_114645_add_res_order_status_column_to_transactions_table', 1),
	(102, '2018_06_05_103530_rename_purchase_line_id_in_stock_adjustment_lines_table', 1),
	(103, '2018_06_05_111905_modify_products_table_for_modifiers', 1),
	(104, '2018_06_06_110524_add_parent_sell_line_id_column_to_transaction_sell_lines_table', 1),
	(105, '2018_06_07_152443_add_is_service_staff_to_roles_table', 1),
	(106, '2018_06_07_182258_add_image_field_to_products_table', 1),
	(107, '2018_06_13_133705_create_bookings_table', 1),
	(108, '2018_06_15_173636_add_email_column_to_contacts_table', 1),
	(109, '2018_06_27_182835_add_superadmin_related_fields_business', 1),
	(110, '2018_07_10_101913_add_custom_fields_to_products_table', 1),
	(111, '2018_07_17_103434_add_sales_person_name_label_to_invoice_layouts_table', 1),
	(112, '2018_07_17_120612_change_all_quantity_field_type_to_decimal', 1),
	(113, '2018_07_17_163920_add_theme_skin_color_column_to_business_table', 1),
	(114, '2018_07_24_160319_add_lot_no_line_id_to_transaction_sell_lines_table', 1),
	(115, '2018_07_25_110004_add_show_expiry_and_show_lot_colums_to_invoice_layouts_table', 1),
	(116, '2018_07_25_172004_add_discount_columns_to_transaction_sell_lines_table', 1),
	(117, '2018_07_26_124720_change_design_column_type_in_invoice_layouts_table', 1),
	(118, '2018_07_26_170424_add_unit_price_before_discount_column_to_transaction_sell_line_table', 1),
	(119, '2018_07_28_103614_add_credit_limit_column_to_contacts_table', 1),
	(120, '2018_08_08_110755_add_new_payment_methods_to_transaction_payments_table', 1),
	(121, '2018_08_08_122225_modify_cash_register_transactions_table_for_new_payment_methods', 1),
	(122, '2018_08_14_104036_add_opening_balance_type_to_transactions_table', 1),
	(123, '2018_09_04_155900_create_accounts_table', 1),
	(124, '2018_09_06_114438_create_selling_price_groups_table', 1),
	(125, '2018_09_06_154057_create_variation_group_prices_table', 1),
	(126, '2018_09_07_102413_add_permission_to_access_default_selling_price', 1),
	(127, '2018_09_07_134858_add_selling_price_group_id_to_transactions_table', 1),
	(128, '2018_09_10_112448_update_product_type_to_single_if_null_in_products_table', 1),
	(129, '2018_09_10_152703_create_account_transactions_table', 1),
	(130, '2018_09_10_173656_add_account_id_column_to_transaction_payments_table', 1),
	(131, '2018_09_19_123914_create_notification_templates_table', 1),
	(132, '2018_09_22_110504_add_sms_and_email_settings_columns_to_business_table', 1),
	(133, '2018_09_24_134942_add_lot_no_line_id_to_stock_adjustment_lines_table', 1),
	(134, '2018_09_26_105557_add_transaction_payments_for_existing_expenses', 1),
	(135, '2018_09_27_111609_modify_transactions_table_for_purchase_return', 1),
	(136, '2018_09_27_131154_add_quantity_returned_column_to_purchase_lines_table', 1),
	(137, '2018_10_02_131401_add_return_quantity_column_to_transaction_sell_lines_table', 1),
	(138, '2018_10_03_104918_add_qty_returned_column_to_transaction_sell_lines_purchase_lines_table', 1),
	(139, '2018_10_03_185947_add_default_notification_templates_to_database', 1),
	(140, '2018_10_09_153105_add_business_id_to_transaction_payments_table', 1),
	(141, '2018_10_16_135229_create_permission_for_sells_and_purchase', 1),
	(142, '2018_10_22_114441_add_columns_for_variable_product_modifications', 1),
	(143, '2018_10_22_134428_modify_variable_product_data', 1),
	(144, '2018_10_30_181558_add_table_tax_headings_to_invoice_layout', 1),
	(145, '2018_10_31_122619_add_pay_terms_field_transactions_table', 1),
	(146, '2018_10_31_161328_add_new_permissions_for_pos_screen', 1),
	(147, '2018_10_31_174752_add_access_selected_contacts_only_to_users_table', 1),
	(148, '2018_10_31_175627_add_user_contact_access', 1),
	(149, '2018_10_31_180559_add_auto_send_sms_column_to_notification_templates_table', 1),
	(150, '2018_11_02_171949_change_card_type_column_to_varchar_in_transaction_payments_table', 1),
	(151, '2018_11_08_105621_add_role_permissions', 1),
	(152, '2018_11_26_114135_add_is_suspend_column_to_transactions_table', 1),
	(153, '2018_11_28_104410_modify_units_table_for_multi_unit', 1),
	(154, '2018_11_28_170952_add_sub_unit_id_to_purchase_lines_and_sell_lines', 1),
	(155, '2018_11_29_115918_add_primary_key_in_system_table', 1),
	(156, '2018_12_03_185546_add_product_description_column_to_products_table', 1),
	(157, '2018_12_06_114937_modify_system_table_and_users_table', 1),
	(158, '2018_12_13_160007_add_custom_fields_display_options_to_invoice_layouts_table', 1),
	(159, '2018_12_14_103307_modify_system_table', 1),
	(160, '2018_12_18_133837_add_prev_balance_due_columns_to_invoice_layouts_table', 1),
	(161, '2018_12_18_170656_add_invoice_token_column_to_transaction_table', 1),
	(162, '2018_12_20_133639_add_date_time_format_column_to_invoice_layouts_table', 1),
	(163, '2018_12_21_120659_add_recurring_invoice_fields_to_transactions_table', 1),
	(164, '2018_12_24_154933_create_notifications_table', 1),
	(165, '2019_01_08_112015_add_document_column_to_transaction_payments_table', 1),
	(166, '2019_01_10_124645_add_account_permission', 1),
	(167, '2019_01_16_125825_add_subscription_no_column_to_transactions_table', 1),
	(168, '2019_01_28_111647_add_order_addresses_column_to_transactions_table', 1),
	(169, '2019_02_13_173821_add_is_inactive_column_to_products_table', 1),
	(170, '2019_02_19_103118_create_discounts_table', 1),
	(171, '2019_02_21_120324_add_discount_id_column_to_transaction_sell_lines_table', 1),
	(172, '2019_02_21_134324_add_permission_for_discount', 1),
	(173, '2019_03_04_170832_add_service_staff_columns_to_transaction_sell_lines_table', 1),
	(174, '2019_03_09_102425_add_sub_type_column_to_transactions_table', 1),
	(175, '2019_03_09_124457_add_indexing_transaction_sell_lines_purchase_lines_table', 1),
	(176, '2019_03_12_120336_create_activity_log_table', 1),
	(177, '2019_03_15_132925_create_media_table', 1),
	(178, '2019_05_08_130339_add_indexing_to_parent_id_in_transaction_payments_table', 1),
	(179, '2019_05_10_132311_add_missing_column_indexing', 1),
	(180, '2019_05_14_091812_add_show_image_column_to_invoice_layouts_table', 1),
	(181, '2019_05_25_104922_add_view_purchase_price_permission', 1),
	(182, '2019_06_17_103515_add_profile_informations_columns_to_users_table', 1);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;

-- Volcando estructura para tabla inventory.model_has_permissions
CREATE TABLE IF NOT EXISTS `model_has_permissions` (
  `permission_id` int(10) unsigned NOT NULL,
  `model_id` int(10) unsigned NOT NULL,
  `model_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`permission_id`,`model_id`,`model_type`),
  KEY `model_has_permissions_model_id_model_type_index` (`model_id`,`model_type`),
  CONSTRAINT `model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla inventory.model_has_permissions: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `model_has_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `model_has_permissions` ENABLE KEYS */;

-- Volcando estructura para tabla inventory.model_has_roles
CREATE TABLE IF NOT EXISTS `model_has_roles` (
  `role_id` int(10) unsigned NOT NULL,
  `model_id` int(10) unsigned NOT NULL,
  `model_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  KEY `model_has_roles_model_id_model_type_index` (`model_id`,`model_type`),
  CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla inventory.model_has_roles: ~3 rows (aproximadamente)
/*!40000 ALTER TABLE `model_has_roles` DISABLE KEYS */;
INSERT INTO `model_has_roles` (`role_id`, `model_id`, `model_type`) VALUES
	(1, 1, 'App\\User'),
	(3, 2, 'App\\User'),
	(5, 3, 'App\\User');
/*!40000 ALTER TABLE `model_has_roles` ENABLE KEYS */;

-- Volcando estructura para tabla inventory.notifications
CREATE TABLE IF NOT EXISTS `notifications` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `notifiable_id` int(10) unsigned NOT NULL,
  `notifiable_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `data` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `read_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `notifications_notifiable_id_notifiable_type_index` (`notifiable_id`,`notifiable_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla inventory.notifications: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;
/*!40000 ALTER TABLE `notifications` ENABLE KEYS */;

-- Volcando estructura para tabla inventory.notification_templates
CREATE TABLE IF NOT EXISTS `notification_templates` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `business_id` int(11) NOT NULL,
  `template_for` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_body` text COLLATE utf8mb4_unicode_ci,
  `sms_body` text COLLATE utf8mb4_unicode_ci,
  `subject` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `auto_send` tinyint(1) NOT NULL DEFAULT '0',
  `auto_send_sms` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla inventory.notification_templates: ~24 rows (aproximadamente)
/*!40000 ALTER TABLE `notification_templates` DISABLE KEYS */;
INSERT INTO `notification_templates` (`id`, `business_id`, `template_for`, `email_body`, `sms_body`, `subject`, `auto_send`, `auto_send_sms`, `created_at`, `updated_at`) VALUES
	(1, 1, 'new_sale', '<p>Dear {contact_name},</p>\r\n\r\n                    <p>Your invoice number is {invoice_number}<br />\r\n                    Total amount: {total_amount}<br />\r\n                    Paid amount: {paid_amount}</p>\r\n\r\n                    <p>Thank you for shopping with us.</p>\r\n\r\n                    <p>{business_logo}</p>\r\n\r\n                    <p>&nbsp;</p>', 'Dear {contact_name}, Thank you for shopping with us. {business_name}', 'Thank you from {business_name}', 0, 0, '2022-01-17 04:55:35', '2022-01-17 04:55:35'),
	(2, 1, 'payment_received', '<p>Dear {contact_name},</p>\r\n\r\n                <p>We have received a payment of {paid_amount}</p>\r\n\r\n                <p>{business_logo}</p>', 'Dear {contact_name}, We have received a payment of {paid_amount}. {business_name}', 'Payment Received, from {business_name}', 0, 0, '2022-01-17 04:55:35', '2022-01-17 04:55:35'),
	(3, 1, 'payment_reminder', '<p>Dear {contact_name},</p>\r\n\r\n                    <p>This is to remind you that you have pending payment of {due_amount}. Kindly pay it as soon as possible.</p>\r\n\r\n                    <p>{business_logo}</p>', 'Dear {contact_name}, You have pending payment of {due_amount}. Kindly pay it as soon as possible. {business_name}', 'Payment Reminder, from {business_name}', 0, 0, '2022-01-17 04:55:35', '2022-01-17 04:55:35'),
	(4, 1, 'new_booking', '<p>Dear {contact_name},</p>\r\n\r\n                    <p>Your booking is confirmed</p>\r\n\r\n                    <p>Date: {start_time} to {end_time}</p>\r\n\r\n                    <p>Table: {table}</p>\r\n\r\n                    <p>Location: {location}</p>\r\n\r\n                    <p>{business_logo}</p>', 'Dear {contact_name}, Your booking is confirmed. Date: {start_time} to {end_time}, Table: {table}, Location: {location}', 'Booking Confirmed - {business_name}', 0, 0, '2022-01-17 04:55:35', '2022-01-17 04:55:35'),
	(5, 1, 'new_order', '<p>Dear {contact_name},</p>\r\n\r\n                    <p>We have a new order with reference number {invoice_number}. Kindly process the products as soon as possible.</p>\r\n\r\n                    <p>{business_name}<br />\r\n                    {business_logo}</p>', 'Dear {contact_name}, We have a new order with reference number {invoice_number}. Kindly process the products as soon as possible. {business_name}', 'New Order, from {business_name}', 0, 0, '2022-01-17 04:55:35', '2022-01-17 04:55:35'),
	(6, 1, 'payment_paid', '<p>Dear {contact_name},</p>\r\n\r\n                    <p>We have paid amount {paid_amount} again invoice number {invoice_number}.<br />\r\n                    Kindly note it down.</p>\r\n\r\n                    <p>{business_name}<br />\r\n                    {business_logo}</p>', 'We have paid amount {paid_amount} again invoice number {invoice_number}.\r\n                    Kindly note it down. {business_name}', 'Payment Paid, from {business_name}', 0, 0, '2022-01-17 04:55:35', '2022-01-17 04:55:35'),
	(7, 1, 'items_received', '<p>Dear {contact_name},</p>\r\n\r\n                    <p>We have received all items from invoice reference number {invoice_number}. Thank you for processing it.</p>\r\n\r\n                    <p>{business_name}<br />\r\n                    {business_logo}</p>', 'We have received all items from invoice reference number {invoice_number}. Thank you for processing it. {business_name}', 'Items received, from {business_name}', 0, 0, '2022-01-17 04:55:35', '2022-01-17 04:55:35'),
	(8, 1, 'items_pending', '<p>Dear {contact_name},<br />\r\n                    This is to remind you that we have not yet received some items from invoice reference number {invoice_number}. Please process it as soon as possible.</p>\r\n\r\n                    <p>{business_name}<br />\r\n                    {business_logo}</p>', 'This is to remind you that we have not yet received some items from invoice reference number {invoice_number} . Please process it as soon as possible.{business_name}', 'Items Pending, from {business_name}', 0, 0, '2022-01-17 04:55:35', '2022-01-17 04:55:35'),
	(9, 2, 'new_sale', '<p>Dear {contact_name},</p>\r\n\r\n                    <p>Your invoice number is {invoice_number}<br />\r\n                    Total amount: {total_amount}<br />\r\n                    Paid amount: {paid_amount}</p>\r\n\r\n                    <p>Thank you for shopping with us.</p>\r\n\r\n                    <p>{business_logo}</p>\r\n\r\n                    <p>&nbsp;</p>', 'Dear {contact_name}, Thank you for shopping with us. {business_name}', 'Thank you from {business_name}', 0, 0, '2022-01-17 21:04:31', '2022-01-17 21:04:31'),
	(10, 2, 'payment_received', '<p>Dear {contact_name},</p>\r\n\r\n                <p>We have received a payment of {paid_amount}</p>\r\n\r\n                <p>{business_logo}</p>', 'Dear {contact_name}, We have received a payment of {paid_amount}. {business_name}', 'Payment Received, from {business_name}', 0, 0, '2022-01-17 21:04:31', '2022-01-17 21:04:31'),
	(11, 2, 'payment_reminder', '<p>Dear {contact_name},</p>\r\n\r\n                    <p>This is to remind you that you have pending payment of {due_amount}. Kindly pay it as soon as possible.</p>\r\n\r\n                    <p>{business_logo}</p>', 'Dear {contact_name}, You have pending payment of {due_amount}. Kindly pay it as soon as possible. {business_name}', 'Payment Reminder, from {business_name}', 0, 0, '2022-01-17 21:04:31', '2022-01-17 21:04:31'),
	(12, 2, 'new_booking', '<p>Dear {contact_name},</p>\r\n\r\n                    <p>Your booking is confirmed</p>\r\n\r\n                    <p>Date: {start_time} to {end_time}</p>\r\n\r\n                    <p>Table: {table}</p>\r\n\r\n                    <p>Location: {location}</p>\r\n\r\n                    <p>{business_logo}</p>', 'Dear {contact_name}, Your booking is confirmed. Date: {start_time} to {end_time}, Table: {table}, Location: {location}', 'Booking Confirmed - {business_name}', 0, 0, '2022-01-17 21:04:31', '2022-01-17 21:04:31'),
	(13, 2, 'new_order', '<p>Dear {contact_name},</p>\r\n\r\n                    <p>We have a new order with reference number {invoice_number}. Kindly process the products as soon as possible.</p>\r\n\r\n                    <p>{business_name}<br />\r\n                    {business_logo}</p>', 'Dear {contact_name}, We have a new order with reference number {invoice_number}. Kindly process the products as soon as possible. {business_name}', 'New Order, from {business_name}', 0, 0, '2022-01-17 21:04:31', '2022-01-17 21:04:31'),
	(14, 2, 'payment_paid', '<p>Dear {contact_name},</p>\r\n\r\n                    <p>We have paid amount {paid_amount} again invoice number {invoice_number}.<br />\r\n                    Kindly note it down.</p>\r\n\r\n                    <p>{business_name}<br />\r\n                    {business_logo}</p>', 'We have paid amount {paid_amount} again invoice number {invoice_number}.\r\n                    Kindly note it down. {business_name}', 'Payment Paid, from {business_name}', 0, 0, '2022-01-17 21:04:31', '2022-01-17 21:04:31'),
	(15, 2, 'items_received', '<p>Dear {contact_name},</p>\r\n\r\n                    <p>We have received all items from invoice reference number {invoice_number}. Thank you for processing it.</p>\r\n\r\n                    <p>{business_name}<br />\r\n                    {business_logo}</p>', 'We have received all items from invoice reference number {invoice_number}. Thank you for processing it. {business_name}', 'Items received, from {business_name}', 0, 0, '2022-01-17 21:04:31', '2022-01-17 21:04:31'),
	(16, 2, 'items_pending', '<p>Dear {contact_name},<br />\r\n                    This is to remind you that we have not yet received some items from invoice reference number {invoice_number}. Please process it as soon as possible.</p>\r\n\r\n                    <p>{business_name}<br />\r\n                    {business_logo}</p>', 'This is to remind you that we have not yet received some items from invoice reference number {invoice_number} . Please process it as soon as possible.{business_name}', 'Items Pending, from {business_name}', 0, 0, '2022-01-17 21:04:31', '2022-01-17 21:04:31'),
	(17, 3, 'new_sale', '<p>Dear {contact_name},</p>\r\n\r\n                    <p>Your invoice number is {invoice_number}<br />\r\n                    Total amount: {total_amount}<br />\r\n                    Paid amount: {paid_amount}</p>\r\n\r\n                    <p>Thank you for shopping with us.</p>\r\n\r\n                    <p>{business_logo}</p>\r\n\r\n                    <p>&nbsp;</p>', 'Dear {contact_name}, Thank you for shopping with us. {business_name}', 'Thank you from {business_name}', 0, 0, '2022-01-18 00:26:12', '2022-01-18 00:26:12'),
	(18, 3, 'payment_received', '<p>Dear {contact_name},</p>\r\n\r\n                <p>We have received a payment of {paid_amount}</p>\r\n\r\n                <p>{business_logo}</p>', 'Dear {contact_name}, We have received a payment of {paid_amount}. {business_name}', 'Payment Received, from {business_name}', 0, 0, '2022-01-18 00:26:12', '2022-01-18 00:26:12'),
	(19, 3, 'payment_reminder', '<p>Dear {contact_name},</p>\r\n\r\n                    <p>This is to remind you that you have pending payment of {due_amount}. Kindly pay it as soon as possible.</p>\r\n\r\n                    <p>{business_logo}</p>', 'Dear {contact_name}, You have pending payment of {due_amount}. Kindly pay it as soon as possible. {business_name}', 'Payment Reminder, from {business_name}', 0, 0, '2022-01-18 00:26:12', '2022-01-18 00:26:12'),
	(20, 3, 'new_booking', '<p>Dear {contact_name},</p>\r\n\r\n                    <p>Your booking is confirmed</p>\r\n\r\n                    <p>Date: {start_time} to {end_time}</p>\r\n\r\n                    <p>Table: {table}</p>\r\n\r\n                    <p>Location: {location}</p>\r\n\r\n                    <p>{business_logo}</p>', 'Dear {contact_name}, Your booking is confirmed. Date: {start_time} to {end_time}, Table: {table}, Location: {location}', 'Booking Confirmed - {business_name}', 0, 0, '2022-01-18 00:26:12', '2022-01-18 00:26:12'),
	(21, 3, 'new_order', '<p>Dear {contact_name},</p>\r\n\r\n                    <p>We have a new order with reference number {invoice_number}. Kindly process the products as soon as possible.</p>\r\n\r\n                    <p>{business_name}<br />\r\n                    {business_logo}</p>', 'Dear {contact_name}, We have a new order with reference number {invoice_number}. Kindly process the products as soon as possible. {business_name}', 'New Order, from {business_name}', 0, 0, '2022-01-18 00:26:12', '2022-01-18 00:26:12'),
	(22, 3, 'payment_paid', '<p>Dear {contact_name},</p>\r\n\r\n                    <p>We have paid amount {paid_amount} again invoice number {invoice_number}.<br />\r\n                    Kindly note it down.</p>\r\n\r\n                    <p>{business_name}<br />\r\n                    {business_logo}</p>', 'We have paid amount {paid_amount} again invoice number {invoice_number}.\r\n                    Kindly note it down. {business_name}', 'Payment Paid, from {business_name}', 0, 0, '2022-01-18 00:26:12', '2022-01-18 00:26:12'),
	(23, 3, 'items_received', '<p>Dear {contact_name},</p>\r\n\r\n                    <p>We have received all items from invoice reference number {invoice_number}. Thank you for processing it.</p>\r\n\r\n                    <p>{business_name}<br />\r\n                    {business_logo}</p>', 'We have received all items from invoice reference number {invoice_number}. Thank you for processing it. {business_name}', 'Items received, from {business_name}', 0, 0, '2022-01-18 00:26:12', '2022-01-18 00:26:12'),
	(24, 3, 'items_pending', '<p>Dear {contact_name},<br />\r\n                    This is to remind you that we have not yet received some items from invoice reference number {invoice_number}. Please process it as soon as possible.</p>\r\n\r\n                    <p>{business_name}<br />\r\n                    {business_logo}</p>', 'This is to remind you that we have not yet received some items from invoice reference number {invoice_number} . Please process it as soon as possible.{business_name}', 'Items Pending, from {business_name}', 0, 0, '2022-01-18 00:26:12', '2022-01-18 00:26:12');
/*!40000 ALTER TABLE `notification_templates` ENABLE KEYS */;

-- Volcando estructura para tabla inventory.password_resets
CREATE TABLE IF NOT EXISTS `password_resets` (
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla inventory.password_resets: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `password_resets` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_resets` ENABLE KEYS */;

-- Volcando estructura para tabla inventory.permissions
CREATE TABLE IF NOT EXISTS `permissions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=75 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla inventory.permissions: ~71 rows (aproximadamente)
/*!40000 ALTER TABLE `permissions` DISABLE KEYS */;
INSERT INTO `permissions` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
	(1, 'profit_loss_report.view', 'web', '2022-01-17 03:41:12', NULL),
	(2, 'direct_sell.access', 'web', '2022-01-17 03:41:12', NULL),
	(3, 'product.opening_stock', 'web', '2022-01-17 03:41:14', '2022-01-17 03:41:14'),
	(4, 'crud_all_bookings', 'web', '2022-01-17 03:41:15', '2022-01-17 03:41:15'),
	(5, 'crud_own_bookings', 'web', '2022-01-17 03:41:15', '2022-01-17 03:41:15'),
	(6, 'access_default_selling_price', 'web', '2022-01-17 03:41:17', '2022-01-17 03:41:17'),
	(7, 'purchase.payments', 'web', '2022-01-17 03:41:18', '2022-01-17 03:41:18'),
	(8, 'sell.payments', 'web', '2022-01-17 03:41:18', '2022-01-17 03:41:18'),
	(9, 'edit_product_price_from_sale_screen', 'web', '2022-01-17 03:41:18', '2022-01-17 03:41:18'),
	(10, 'edit_product_discount_from_sale_screen', 'web', '2022-01-17 03:41:18', '2022-01-17 03:41:18'),
	(11, 'roles.view', 'web', '2022-01-17 03:41:18', '2022-01-17 03:41:18'),
	(12, 'roles.create', 'web', '2022-01-17 03:41:18', '2022-01-17 03:41:18'),
	(13, 'roles.update', 'web', '2022-01-17 03:41:18', '2022-01-17 03:41:18'),
	(14, 'roles.delete', 'web', '2022-01-17 03:41:18', '2022-01-17 03:41:18'),
	(15, 'account.access', 'web', '2022-01-17 03:41:20', '2022-01-17 03:41:20'),
	(16, 'discount.access', 'web', '2022-01-17 03:41:20', '2022-01-17 03:41:20'),
	(17, 'view_purchase_price', 'web', '2022-01-17 03:41:21', '2022-01-17 03:41:21'),
	(18, 'user.view', 'web', '2022-01-17 04:52:30', NULL),
	(19, 'user.create', 'web', '2022-01-17 04:52:30', NULL),
	(20, 'user.update', 'web', '2022-01-17 04:52:30', NULL),
	(21, 'user.delete', 'web', '2022-01-17 04:52:30', NULL),
	(22, 'supplier.view', 'web', '2022-01-17 04:52:30', NULL),
	(23, 'supplier.create', 'web', '2022-01-17 04:52:30', NULL),
	(24, 'supplier.update', 'web', '2022-01-17 04:52:30', NULL),
	(25, 'supplier.delete', 'web', '2022-01-17 04:52:30', NULL),
	(26, 'customer.view', 'web', '2022-01-17 04:52:30', NULL),
	(27, 'customer.create', 'web', '2022-01-17 04:52:30', NULL),
	(28, 'customer.update', 'web', '2022-01-17 04:52:30', NULL),
	(29, 'customer.delete', 'web', '2022-01-17 04:52:30', NULL),
	(30, 'product.view', 'web', '2022-01-17 04:52:30', NULL),
	(31, 'product.create', 'web', '2022-01-17 04:52:30', NULL),
	(32, 'product.update', 'web', '2022-01-17 04:52:30', NULL),
	(33, 'product.delete', 'web', '2022-01-17 04:52:30', NULL),
	(34, 'purchase.view', 'web', '2022-01-17 04:52:30', NULL),
	(35, 'purchase.create', 'web', '2022-01-17 04:52:30', NULL),
	(36, 'purchase.update', 'web', '2022-01-17 04:52:30', NULL),
	(37, 'purchase.delete', 'web', '2022-01-17 04:52:30', NULL),
	(38, 'sell.view', 'web', '2022-01-17 04:52:30', NULL),
	(39, 'sell.create', 'web', '2022-01-17 04:52:30', NULL),
	(40, 'sell.update', 'web', '2022-01-17 04:52:30', NULL),
	(41, 'sell.delete', 'web', '2022-01-17 04:52:30', NULL),
	(42, 'purchase_n_sell_report.view', 'web', '2022-01-17 04:52:30', NULL),
	(43, 'contacts_report.view', 'web', '2022-01-17 04:52:30', NULL),
	(44, 'stock_report.view', 'web', '2022-01-17 04:52:30', NULL),
	(45, 'tax_report.view', 'web', '2022-01-17 04:52:30', NULL),
	(46, 'trending_product_report.view', 'web', '2022-01-17 04:52:30', NULL),
	(47, 'register_report.view', 'web', '2022-01-17 04:52:30', NULL),
	(48, 'sales_representative.view', 'web', '2022-01-17 04:52:30', NULL),
	(49, 'expense_report.view', 'web', '2022-01-17 04:52:30', NULL),
	(50, 'business_settings.access', 'web', '2022-01-17 04:52:30', NULL),
	(51, 'barcode_settings.access', 'web', '2022-01-17 04:52:30', NULL),
	(52, 'invoice_settings.access', 'web', '2022-01-17 04:52:30', NULL),
	(53, 'brand.view', 'web', '2022-01-17 04:52:30', NULL),
	(54, 'brand.create', 'web', '2022-01-17 04:52:30', NULL),
	(55, 'brand.update', 'web', '2022-01-17 04:52:30', NULL),
	(56, 'brand.delete', 'web', '2022-01-17 04:52:30', NULL),
	(57, 'tax_rate.view', 'web', '2022-01-17 04:52:30', NULL),
	(58, 'tax_rate.create', 'web', '2022-01-17 04:52:30', NULL),
	(59, 'tax_rate.update', 'web', '2022-01-17 04:52:30', NULL),
	(60, 'tax_rate.delete', 'web', '2022-01-17 04:52:30', NULL),
	(61, 'unit.view', 'web', '2022-01-17 04:52:30', NULL),
	(62, 'unit.create', 'web', '2022-01-17 04:52:30', NULL),
	(63, 'unit.update', 'web', '2022-01-17 04:52:30', NULL),
	(64, 'unit.delete', 'web', '2022-01-17 04:52:30', NULL),
	(65, 'category.view', 'web', '2022-01-17 04:52:30', NULL),
	(66, 'category.create', 'web', '2022-01-17 04:52:30', NULL),
	(67, 'category.update', 'web', '2022-01-17 04:52:30', NULL),
	(68, 'category.delete', 'web', '2022-01-17 04:52:30', NULL),
	(69, 'expense.access', 'web', '2022-01-17 04:52:30', NULL),
	(70, 'access_all_locations', 'web', '2022-01-17 04:52:30', NULL),
	(71, 'dashboard.data', 'web', '2022-01-17 04:52:30', NULL),
	(72, 'location.1', 'web', '2022-01-17 04:55:35', '2022-01-17 04:55:35'),
	(73, 'location.2', 'web', '2022-01-17 21:04:31', '2022-01-17 21:04:31'),
	(74, 'location.3', 'web', '2022-01-18 00:26:12', '2022-01-18 00:26:12');
/*!40000 ALTER TABLE `permissions` ENABLE KEYS */;

-- Volcando estructura para tabla inventory.printers
CREATE TABLE IF NOT EXISTS `printers` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `business_id` int(10) unsigned NOT NULL,
  `name` varchar(256) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection_type` enum('network','windows','linux') COLLATE utf8mb4_unicode_ci NOT NULL,
  `capability_profile` enum('default','simple','SP2000','TEP-200M','P822D') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'default',
  `char_per_line` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ip_address` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `port` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `path` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `printers_business_id_foreign` (`business_id`),
  CONSTRAINT `printers_business_id_foreign` FOREIGN KEY (`business_id`) REFERENCES `business` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla inventory.printers: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `printers` DISABLE KEYS */;
/*!40000 ALTER TABLE `printers` ENABLE KEYS */;

-- Volcando estructura para tabla inventory.products
CREATE TABLE IF NOT EXISTS `products` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `business_id` int(10) unsigned NOT NULL,
  `type` enum('single','variable','modifier') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `unit_id` int(11) unsigned DEFAULT NULL,
  `brand_id` int(10) unsigned DEFAULT NULL,
  `category_id` int(10) unsigned DEFAULT NULL,
  `sub_category_id` int(10) unsigned DEFAULT NULL,
  `tax` int(10) unsigned DEFAULT NULL,
  `tax_type` enum('inclusive','exclusive') COLLATE utf8mb4_unicode_ci NOT NULL,
  `enable_stock` tinyint(1) NOT NULL DEFAULT '0',
  `alert_quantity` int(11) NOT NULL DEFAULT '0',
  `sku` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `barcode_type` enum('C39','C128','EAN13','EAN8','UPCA','UPCE') COLLATE utf8mb4_unicode_ci DEFAULT 'C128',
  `expiry_period` decimal(4,2) DEFAULT NULL,
  `expiry_period_type` enum('days','months') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `enable_sr_no` tinyint(1) NOT NULL DEFAULT '0',
  `weight` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `product_custom_field1` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `product_custom_field2` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `product_custom_field3` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `product_custom_field4` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `product_description` text COLLATE utf8mb4_unicode_ci,
  `created_by` int(10) unsigned NOT NULL,
  `is_inactive` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `products_brand_id_foreign` (`brand_id`),
  KEY `products_category_id_foreign` (`category_id`),
  KEY `products_sub_category_id_foreign` (`sub_category_id`),
  KEY `products_tax_foreign` (`tax`),
  KEY `products_name_index` (`name`),
  KEY `products_business_id_index` (`business_id`),
  KEY `products_unit_id_index` (`unit_id`),
  KEY `products_created_by_index` (`created_by`),
  CONSTRAINT `products_brand_id_foreign` FOREIGN KEY (`brand_id`) REFERENCES `brands` (`id`) ON DELETE CASCADE,
  CONSTRAINT `products_business_id_foreign` FOREIGN KEY (`business_id`) REFERENCES `business` (`id`) ON DELETE CASCADE,
  CONSTRAINT `products_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE,
  CONSTRAINT `products_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `products_sub_category_id_foreign` FOREIGN KEY (`sub_category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE,
  CONSTRAINT `products_tax_foreign` FOREIGN KEY (`tax`) REFERENCES `tax_rates` (`id`),
  CONSTRAINT `products_unit_id_foreign` FOREIGN KEY (`unit_id`) REFERENCES `units` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla inventory.products: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
/*!40000 ALTER TABLE `products` ENABLE KEYS */;

-- Volcando estructura para tabla inventory.product_racks
CREATE TABLE IF NOT EXISTS `product_racks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `business_id` int(10) unsigned NOT NULL,
  `location_id` int(10) unsigned NOT NULL,
  `product_id` int(10) unsigned NOT NULL,
  `rack` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `row` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `position` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla inventory.product_racks: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `product_racks` DISABLE KEYS */;
/*!40000 ALTER TABLE `product_racks` ENABLE KEYS */;

-- Volcando estructura para tabla inventory.product_variations
CREATE TABLE IF NOT EXISTS `product_variations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `variation_template_id` int(11) DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `product_id` int(10) unsigned NOT NULL,
  `is_dummy` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `product_variations_name_index` (`name`),
  KEY `product_variations_product_id_index` (`product_id`),
  CONSTRAINT `product_variations_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla inventory.product_variations: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `product_variations` DISABLE KEYS */;
/*!40000 ALTER TABLE `product_variations` ENABLE KEYS */;

-- Volcando estructura para tabla inventory.purchase_lines
CREATE TABLE IF NOT EXISTS `purchase_lines` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `transaction_id` int(10) unsigned NOT NULL,
  `product_id` int(10) unsigned NOT NULL,
  `variation_id` int(10) unsigned NOT NULL,
  `quantity` decimal(20,4) NOT NULL,
  `pp_without_discount` decimal(20,2) NOT NULL DEFAULT '0.00' COMMENT 'Purchase price before inline discounts',
  `discount_percent` decimal(5,2) NOT NULL DEFAULT '0.00' COMMENT 'Inline discount percentage',
  `purchase_price` decimal(20,2) DEFAULT NULL,
  `purchase_price_inc_tax` decimal(20,2) NOT NULL DEFAULT '0.00',
  `item_tax` decimal(20,2) DEFAULT NULL,
  `tax_id` int(10) unsigned DEFAULT NULL,
  `quantity_sold` decimal(20,4) DEFAULT '0.0000',
  `quantity_adjusted` decimal(20,4) DEFAULT '0.0000',
  `quantity_returned` decimal(20,4) NOT NULL DEFAULT '0.0000',
  `mfg_date` date DEFAULT NULL,
  `exp_date` date DEFAULT NULL,
  `lot_number` varchar(256) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sub_unit_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `purchase_lines_transaction_id_foreign` (`transaction_id`),
  KEY `purchase_lines_product_id_foreign` (`product_id`),
  KEY `purchase_lines_variation_id_foreign` (`variation_id`),
  KEY `purchase_lines_tax_id_foreign` (`tax_id`),
  KEY `purchase_lines_sub_unit_id_index` (`sub_unit_id`),
  CONSTRAINT `purchase_lines_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  CONSTRAINT `purchase_lines_tax_id_foreign` FOREIGN KEY (`tax_id`) REFERENCES `tax_rates` (`id`) ON DELETE CASCADE,
  CONSTRAINT `purchase_lines_transaction_id_foreign` FOREIGN KEY (`transaction_id`) REFERENCES `transactions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `purchase_lines_variation_id_foreign` FOREIGN KEY (`variation_id`) REFERENCES `variations` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla inventory.purchase_lines: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `purchase_lines` DISABLE KEYS */;
/*!40000 ALTER TABLE `purchase_lines` ENABLE KEYS */;

-- Volcando estructura para tabla inventory.reference_counts
CREATE TABLE IF NOT EXISTS `reference_counts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ref_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ref_count` int(11) NOT NULL,
  `business_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla inventory.reference_counts: ~6 rows (aproximadamente)
/*!40000 ALTER TABLE `reference_counts` DISABLE KEYS */;
INSERT INTO `reference_counts` (`id`, `ref_type`, `ref_count`, `business_id`, `created_at`, `updated_at`) VALUES
	(1, 'contacts', 1, 1, '2022-01-17 04:55:35', '2022-01-17 04:55:35'),
	(2, 'business_location', 1, 1, '2022-01-17 04:55:35', '2022-01-17 04:55:35'),
	(3, 'contacts', 1, 2, '2022-01-17 21:04:31', '2022-01-17 21:04:31'),
	(4, 'business_location', 1, 2, '2022-01-17 21:04:31', '2022-01-17 21:04:31'),
	(5, 'contacts', 1, 3, '2022-01-18 00:26:12', '2022-01-18 00:26:12'),
	(6, 'business_location', 1, 3, '2022-01-18 00:26:12', '2022-01-18 00:26:12');
/*!40000 ALTER TABLE `reference_counts` ENABLE KEYS */;

-- Volcando estructura para tabla inventory.res_product_modifier_sets
CREATE TABLE IF NOT EXISTS `res_product_modifier_sets` (
  `modifier_set_id` int(10) unsigned NOT NULL,
  `product_id` int(10) unsigned NOT NULL COMMENT 'Table use to store the modifier sets applicable for a product',
  KEY `res_product_modifier_sets_modifier_set_id_foreign` (`modifier_set_id`),
  CONSTRAINT `res_product_modifier_sets_modifier_set_id_foreign` FOREIGN KEY (`modifier_set_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla inventory.res_product_modifier_sets: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `res_product_modifier_sets` DISABLE KEYS */;
/*!40000 ALTER TABLE `res_product_modifier_sets` ENABLE KEYS */;

-- Volcando estructura para tabla inventory.res_tables
CREATE TABLE IF NOT EXISTS `res_tables` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `business_id` int(10) unsigned NOT NULL,
  `location_id` int(10) unsigned NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `created_by` int(10) unsigned NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `res_tables_business_id_foreign` (`business_id`),
  CONSTRAINT `res_tables_business_id_foreign` FOREIGN KEY (`business_id`) REFERENCES `business` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla inventory.res_tables: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `res_tables` DISABLE KEYS */;
/*!40000 ALTER TABLE `res_tables` ENABLE KEYS */;

-- Volcando estructura para tabla inventory.roles
CREATE TABLE IF NOT EXISTS `roles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `business_id` int(10) unsigned NOT NULL,
  `is_default` tinyint(1) NOT NULL DEFAULT '0',
  `is_service_staff` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `roles_business_id_foreign` (`business_id`),
  CONSTRAINT `roles_business_id_foreign` FOREIGN KEY (`business_id`) REFERENCES `business` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla inventory.roles: ~6 rows (aproximadamente)
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` (`id`, `name`, `guard_name`, `business_id`, `is_default`, `is_service_staff`, `created_at`, `updated_at`) VALUES
	(1, 'Admin#1', 'web', 1, 1, 0, '2022-01-17 04:55:35', '2022-01-17 04:55:35'),
	(2, 'Cashier#1', 'web', 1, 0, 0, '2022-01-17 04:55:35', '2022-01-17 04:55:35'),
	(3, 'Admin#2', 'web', 2, 1, 0, '2022-01-17 21:04:31', '2022-01-17 21:04:31'),
	(4, 'Cashier#2', 'web', 2, 0, 0, '2022-01-17 21:04:31', '2022-01-17 21:04:31'),
	(5, 'Admin#3', 'web', 3, 1, 0, '2022-01-18 00:26:11', '2022-01-18 00:26:11'),
	(6, 'Cashier#3', 'web', 3, 0, 0, '2022-01-18 00:26:11', '2022-01-18 00:26:11');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;

-- Volcando estructura para tabla inventory.role_has_permissions
CREATE TABLE IF NOT EXISTS `role_has_permissions` (
  `permission_id` int(10) unsigned NOT NULL,
  `role_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`permission_id`,`role_id`),
  KEY `role_has_permissions_role_id_foreign` (`role_id`),
  CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla inventory.role_has_permissions: ~13 rows (aproximadamente)
/*!40000 ALTER TABLE `role_has_permissions` DISABLE KEYS */;
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES
	(38, 2),
	(39, 2),
	(40, 2),
	(41, 2),
	(70, 2),
	(38, 4),
	(39, 4),
	(40, 4),
	(41, 4),
	(70, 4),
	(38, 6),
	(39, 6),
	(40, 6),
	(41, 6),
	(70, 6);
/*!40000 ALTER TABLE `role_has_permissions` ENABLE KEYS */;

-- Volcando estructura para tabla inventory.selling_price_groups
CREATE TABLE IF NOT EXISTS `selling_price_groups` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `business_id` int(10) unsigned NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `selling_price_groups_business_id_foreign` (`business_id`),
  CONSTRAINT `selling_price_groups_business_id_foreign` FOREIGN KEY (`business_id`) REFERENCES `business` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla inventory.selling_price_groups: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `selling_price_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `selling_price_groups` ENABLE KEYS */;

-- Volcando estructura para tabla inventory.sessions
CREATE TABLE IF NOT EXISTS `sessions` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(10) unsigned DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `payload` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int(11) NOT NULL,
  UNIQUE KEY `sessions_id_unique` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla inventory.sessions: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;

-- Volcando estructura para tabla inventory.stock_adjustments_temp
CREATE TABLE IF NOT EXISTS `stock_adjustments_temp` (
  `id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla inventory.stock_adjustments_temp: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `stock_adjustments_temp` DISABLE KEYS */;
/*!40000 ALTER TABLE `stock_adjustments_temp` ENABLE KEYS */;

-- Volcando estructura para tabla inventory.stock_adjustment_lines
CREATE TABLE IF NOT EXISTS `stock_adjustment_lines` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `transaction_id` int(10) unsigned NOT NULL,
  `product_id` int(10) unsigned NOT NULL,
  `variation_id` int(10) unsigned NOT NULL,
  `quantity` decimal(20,4) NOT NULL,
  `unit_price` decimal(20,2) DEFAULT NULL COMMENT 'Last purchase unit price',
  `removed_purchase_line` int(11) DEFAULT NULL,
  `lot_no_line_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `stock_adjustment_lines_product_id_foreign` (`product_id`),
  KEY `stock_adjustment_lines_variation_id_foreign` (`variation_id`),
  KEY `stock_adjustment_lines_transaction_id_index` (`transaction_id`),
  CONSTRAINT `stock_adjustment_lines_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  CONSTRAINT `stock_adjustment_lines_transaction_id_foreign` FOREIGN KEY (`transaction_id`) REFERENCES `transactions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `stock_adjustment_lines_variation_id_foreign` FOREIGN KEY (`variation_id`) REFERENCES `variations` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla inventory.stock_adjustment_lines: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `stock_adjustment_lines` DISABLE KEYS */;
/*!40000 ALTER TABLE `stock_adjustment_lines` ENABLE KEYS */;

-- Volcando estructura para tabla inventory.system
CREATE TABLE IF NOT EXISTS `system` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla inventory.system: ~2 rows (aproximadamente)
/*!40000 ALTER TABLE `system` DISABLE KEYS */;
INSERT INTO `system` (`id`, `key`, `value`) VALUES
	(1, 'db_version', '2.14.3'),
	(2, 'default_business_active_status', '1');
/*!40000 ALTER TABLE `system` ENABLE KEYS */;

-- Volcando estructura para tabla inventory.tax_rates
CREATE TABLE IF NOT EXISTS `tax_rates` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `business_id` int(10) unsigned NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` double(8,2) NOT NULL,
  `is_tax_group` tinyint(1) NOT NULL DEFAULT '0',
  `created_by` int(10) unsigned NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `tax_rates_business_id_foreign` (`business_id`),
  KEY `tax_rates_created_by_foreign` (`created_by`),
  CONSTRAINT `tax_rates_business_id_foreign` FOREIGN KEY (`business_id`) REFERENCES `business` (`id`) ON DELETE CASCADE,
  CONSTRAINT `tax_rates_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla inventory.tax_rates: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `tax_rates` DISABLE KEYS */;
/*!40000 ALTER TABLE `tax_rates` ENABLE KEYS */;

-- Volcando estructura para tabla inventory.transactions
CREATE TABLE IF NOT EXISTS `transactions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `business_id` int(10) unsigned NOT NULL,
  `location_id` int(10) unsigned NOT NULL,
  `res_table_id` int(10) unsigned DEFAULT NULL COMMENT 'fields to restaurant module',
  `res_waiter_id` int(10) unsigned DEFAULT NULL COMMENT 'fields to restaurant module',
  `res_order_status` enum('received','cooked','served') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` enum('purchase','sell','expense','stock_adjustment','sell_transfer','purchase_transfer','opening_stock','sell_return','opening_balance','purchase_return') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sub_type` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('received','pending','ordered','draft','final') COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_quotation` tinyint(1) NOT NULL DEFAULT '0',
  `payment_status` enum('paid','due','partial') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `adjustment_type` enum('normal','abnormal') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_id` int(11) unsigned DEFAULT NULL,
  `customer_group_id` int(11) DEFAULT NULL COMMENT 'used to add customer group while selling',
  `invoice_no` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ref_no` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `subscription_no` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `transaction_date` datetime NOT NULL,
  `total_before_tax` decimal(20,2) NOT NULL DEFAULT '0.00',
  `tax_id` int(10) unsigned DEFAULT NULL,
  `tax_amount` decimal(20,2) NOT NULL DEFAULT '0.00',
  `discount_type` enum('fixed','percentage') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `discount_amount` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `shipping_details` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `shipping_charges` decimal(20,2) NOT NULL DEFAULT '0.00',
  `additional_notes` text COLLATE utf8mb4_unicode_ci,
  `staff_note` text COLLATE utf8mb4_unicode_ci,
  `final_total` decimal(20,2) NOT NULL DEFAULT '0.00',
  `expense_category_id` int(10) unsigned DEFAULT NULL,
  `expense_for` int(10) unsigned DEFAULT NULL,
  `commission_agent` int(11) DEFAULT NULL,
  `document` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_direct_sale` tinyint(1) NOT NULL DEFAULT '0',
  `is_suspend` tinyint(1) NOT NULL DEFAULT '0',
  `exchange_rate` decimal(20,3) NOT NULL DEFAULT '1.000',
  `total_amount_recovered` decimal(20,2) DEFAULT NULL COMMENT 'Used for stock adjustment.',
  `transfer_parent_id` int(11) DEFAULT NULL,
  `return_parent_id` int(11) DEFAULT NULL,
  `opening_stock_product_id` int(11) DEFAULT NULL,
  `created_by` int(10) unsigned NOT NULL,
  `order_addresses` text COLLATE utf8mb4_unicode_ci,
  `is_recurring` tinyint(1) NOT NULL DEFAULT '0',
  `recur_interval` double(8,2) DEFAULT NULL,
  `recur_interval_type` enum('days','months','years') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `recur_repetitions` int(11) DEFAULT NULL,
  `recur_stopped_on` datetime DEFAULT NULL,
  `recur_parent_id` int(11) DEFAULT NULL,
  `invoice_token` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pay_term_number` int(11) DEFAULT NULL,
  `pay_term_type` enum('days','months') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `selling_price_group_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `transactions_tax_id_foreign` (`tax_id`),
  KEY `transactions_business_id_index` (`business_id`),
  KEY `transactions_type_index` (`type`),
  KEY `transactions_contact_id_index` (`contact_id`),
  KEY `transactions_transaction_date_index` (`transaction_date`),
  KEY `transactions_created_by_index` (`created_by`),
  KEY `transactions_location_id_index` (`location_id`),
  KEY `transactions_expense_for_foreign` (`expense_for`),
  KEY `transactions_expense_category_id_index` (`expense_category_id`),
  KEY `transactions_sub_type_index` (`sub_type`),
  KEY `transactions_return_parent_id_index` (`return_parent_id`),
  CONSTRAINT `transactions_business_id_foreign` FOREIGN KEY (`business_id`) REFERENCES `business` (`id`) ON DELETE CASCADE,
  CONSTRAINT `transactions_contact_id_foreign` FOREIGN KEY (`contact_id`) REFERENCES `contacts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `transactions_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `transactions_expense_category_id_foreign` FOREIGN KEY (`expense_category_id`) REFERENCES `expense_categories` (`id`) ON DELETE CASCADE,
  CONSTRAINT `transactions_expense_for_foreign` FOREIGN KEY (`expense_for`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `transactions_location_id_foreign` FOREIGN KEY (`location_id`) REFERENCES `business_locations` (`id`),
  CONSTRAINT `transactions_tax_id_foreign` FOREIGN KEY (`tax_id`) REFERENCES `tax_rates` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla inventory.transactions: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `transactions` DISABLE KEYS */;
/*!40000 ALTER TABLE `transactions` ENABLE KEYS */;

-- Volcando estructura para tabla inventory.transaction_payments
CREATE TABLE IF NOT EXISTS `transaction_payments` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `transaction_id` int(11) unsigned DEFAULT NULL,
  `business_id` int(11) DEFAULT NULL,
  `is_return` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Used during sales to return the change',
  `amount` decimal(20,2) NOT NULL DEFAULT '0.00',
  `method` enum('cash','card','cheque','bank_transfer','custom_pay_1','custom_pay_2','custom_pay_3','other') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `transaction_no` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `card_transaction_number` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `card_number` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `card_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `card_holder_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `card_month` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `card_year` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `card_security` varchar(5) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cheque_number` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bank_account_number` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `paid_on` datetime DEFAULT NULL,
  `created_by` int(11) NOT NULL,
  `payment_for` int(11) DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `note` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `document` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_ref_no` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `account_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `transaction_payments_transaction_id_foreign` (`transaction_id`),
  KEY `transaction_payments_created_by_index` (`created_by`),
  KEY `transaction_payments_parent_id_index` (`parent_id`),
  CONSTRAINT `transaction_payments_transaction_id_foreign` FOREIGN KEY (`transaction_id`) REFERENCES `transactions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla inventory.transaction_payments: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `transaction_payments` DISABLE KEYS */;
/*!40000 ALTER TABLE `transaction_payments` ENABLE KEYS */;

-- Volcando estructura para tabla inventory.transaction_sell_lines
CREATE TABLE IF NOT EXISTS `transaction_sell_lines` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `transaction_id` int(10) unsigned NOT NULL,
  `product_id` int(10) unsigned NOT NULL,
  `variation_id` int(10) unsigned NOT NULL,
  `quantity` decimal(20,4) NOT NULL,
  `quantity_returned` decimal(20,4) NOT NULL DEFAULT '0.0000',
  `unit_price_before_discount` decimal(20,2) NOT NULL DEFAULT '0.00',
  `unit_price` decimal(20,2) DEFAULT NULL,
  `line_discount_type` enum('fixed','percentage') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `line_discount_amount` decimal(20,2) NOT NULL DEFAULT '0.00',
  `unit_price_inc_tax` decimal(20,2) DEFAULT NULL,
  `item_tax` decimal(20,2) DEFAULT NULL,
  `tax_id` int(10) unsigned DEFAULT NULL,
  `discount_id` int(11) DEFAULT NULL,
  `lot_no_line_id` int(11) DEFAULT NULL,
  `sell_line_note` text COLLATE utf8mb4_unicode_ci,
  `res_service_staff_id` int(11) DEFAULT NULL,
  `res_line_order_status` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parent_sell_line_id` int(11) DEFAULT NULL,
  `sub_unit_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `transaction_sell_lines_transaction_id_foreign` (`transaction_id`),
  KEY `transaction_sell_lines_product_id_foreign` (`product_id`),
  KEY `transaction_sell_lines_variation_id_foreign` (`variation_id`),
  KEY `transaction_sell_lines_tax_id_foreign` (`tax_id`),
  CONSTRAINT `transaction_sell_lines_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  CONSTRAINT `transaction_sell_lines_tax_id_foreign` FOREIGN KEY (`tax_id`) REFERENCES `tax_rates` (`id`) ON DELETE CASCADE,
  CONSTRAINT `transaction_sell_lines_transaction_id_foreign` FOREIGN KEY (`transaction_id`) REFERENCES `transactions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `transaction_sell_lines_variation_id_foreign` FOREIGN KEY (`variation_id`) REFERENCES `variations` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla inventory.transaction_sell_lines: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `transaction_sell_lines` DISABLE KEYS */;
/*!40000 ALTER TABLE `transaction_sell_lines` ENABLE KEYS */;

-- Volcando estructura para tabla inventory.transaction_sell_lines_purchase_lines
CREATE TABLE IF NOT EXISTS `transaction_sell_lines_purchase_lines` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `sell_line_id` int(10) unsigned DEFAULT NULL COMMENT 'id from transaction_sell_lines',
  `stock_adjustment_line_id` int(10) unsigned DEFAULT NULL COMMENT 'id from stock_adjustment_lines',
  `purchase_line_id` int(10) unsigned NOT NULL COMMENT 'id from purchase_lines',
  `quantity` decimal(20,4) NOT NULL,
  `qty_returned` decimal(20,4) NOT NULL DEFAULT '0.0000',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `sell_line_id` (`sell_line_id`),
  KEY `stock_adjustment_line_id` (`stock_adjustment_line_id`),
  KEY `purchase_line_id` (`purchase_line_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla inventory.transaction_sell_lines_purchase_lines: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `transaction_sell_lines_purchase_lines` DISABLE KEYS */;
/*!40000 ALTER TABLE `transaction_sell_lines_purchase_lines` ENABLE KEYS */;

-- Volcando estructura para tabla inventory.units
CREATE TABLE IF NOT EXISTS `units` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `business_id` int(10) unsigned NOT NULL,
  `actual_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `short_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `allow_decimal` tinyint(1) NOT NULL,
  `base_unit_id` int(11) DEFAULT NULL,
  `base_unit_multiplier` decimal(20,4) DEFAULT NULL,
  `created_by` int(10) unsigned NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `units_business_id_foreign` (`business_id`),
  KEY `units_created_by_foreign` (`created_by`),
  KEY `units_base_unit_id_index` (`base_unit_id`),
  CONSTRAINT `units_business_id_foreign` FOREIGN KEY (`business_id`) REFERENCES `business` (`id`) ON DELETE CASCADE,
  CONSTRAINT `units_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla inventory.units: ~3 rows (aproximadamente)
/*!40000 ALTER TABLE `units` DISABLE KEYS */;
INSERT INTO `units` (`id`, `business_id`, `actual_name`, `short_name`, `allow_decimal`, `base_unit_id`, `base_unit_multiplier`, `created_by`, `deleted_at`, `created_at`, `updated_at`) VALUES
	(1, 1, 'Pieces', 'Pc(s)', 0, NULL, NULL, 1, NULL, '2022-01-17 04:55:35', '2022-01-17 04:55:35'),
	(2, 2, 'Pieces', 'Pc(s)', 0, NULL, NULL, 2, NULL, '2022-01-17 21:04:31', '2022-01-17 21:04:31'),
	(3, 3, 'Pieces', 'Pc(s)', 0, NULL, NULL, 3, NULL, '2022-01-18 00:26:12', '2022-01-18 00:26:12');
/*!40000 ALTER TABLE `units` ENABLE KEYS */;

-- Volcando estructura para tabla inventory.users
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `surname` char(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `first_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `username` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `language` char(4) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'en',
  `contact_no` char(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` text COLLATE utf8mb4_unicode_ci,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `business_id` int(10) unsigned DEFAULT NULL,
  `status` enum('active','inactive','terminated') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `is_cmmsn_agnt` tinyint(1) NOT NULL DEFAULT '0',
  `cmmsn_percent` decimal(4,2) NOT NULL DEFAULT '0.00',
  `selected_contacts` tinyint(1) NOT NULL DEFAULT '0',
  `dob` date DEFAULT NULL,
  `marital_status` enum('married','unmarried','divorced') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `blood_group` char(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_number` char(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fb_link` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `twitter_link` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `social_media_1` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `social_media_2` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `permanent_address` text COLLATE utf8mb4_unicode_ci,
  `current_address` text COLLATE utf8mb4_unicode_ci,
  `guardian_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `custom_field_1` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `custom_field_2` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `custom_field_3` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `custom_field_4` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bank_details` longtext COLLATE utf8mb4_unicode_ci,
  `id_proof_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `id_proof_number` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_username_unique` (`username`),
  KEY `users_business_id_foreign` (`business_id`),
  CONSTRAINT `users_business_id_foreign` FOREIGN KEY (`business_id`) REFERENCES `business` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla inventory.users: ~3 rows (aproximadamente)
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`id`, `surname`, `first_name`, `last_name`, `username`, `email`, `password`, `language`, `contact_no`, `address`, `remember_token`, `business_id`, `status`, `is_cmmsn_agnt`, `cmmsn_percent`, `selected_contacts`, `dob`, `marital_status`, `blood_group`, `contact_number`, `fb_link`, `twitter_link`, `social_media_1`, `social_media_2`, `permanent_address`, `current_address`, `guardian_name`, `custom_field_1`, `custom_field_2`, `custom_field_3`, `custom_field_4`, `bank_details`, `id_proof_name`, `id_proof_number`, `deleted_at`, `created_at`, `updated_at`) VALUES
	(1, NULL, 'Juan', 'Chehin', 'chehin', 'sgmtucuman@gmail.com', '$2y$10$TPMxV4FzXcvRpNmjmhC6iejO8BqI0cyO.RYPB6JYURo2xl7WDHGJy', 'en', NULL, NULL, 'MFeErWRJqUU4W7x57JXAPEHtXrDI4CxLIScAic4GXHKi6ab4cYwIf50WoQU2', 1, 'active', 0, 0.00, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2022-01-17 04:55:34', '2022-01-17 04:55:35'),
	(2, 'JC', 'Juan', 'Chehin', 'chehinj', NULL, '$2y$10$zr0GFMLDJR420OJ1iVrqg.3N9koFMLyY63YLIKvqHTHaJO4qux/QG', 'es', NULL, NULL, NULL, 2, 'active', 0, 0.00, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2022-01-17 21:04:31', '2022-01-17 21:04:31'),
	(3, '3865', 'Juan', 'Chehin', 'chehin238', 'chehin@gmail.com', '$2y$10$5RypyMnUTAQe230B4868vOFiScUcQb5m3E7GEjKYhT3nKkN.cp8Pa', 'en', NULL, NULL, NULL, 3, 'active', 0, 0.00, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2022-01-18 00:26:11', '2022-01-18 00:26:11');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;

-- Volcando estructura para tabla inventory.user_contact_access
CREATE TABLE IF NOT EXISTS `user_contact_access` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `contact_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla inventory.user_contact_access: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `user_contact_access` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_contact_access` ENABLE KEYS */;

-- Volcando estructura para tabla inventory.variations
CREATE TABLE IF NOT EXISTS `variations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `product_id` int(10) unsigned NOT NULL,
  `sub_sku` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `product_variation_id` int(10) unsigned NOT NULL,
  `variation_value_id` int(11) DEFAULT NULL,
  `default_purchase_price` decimal(20,2) DEFAULT NULL,
  `dpp_inc_tax` decimal(20,2) NOT NULL DEFAULT '0.00',
  `profit_percent` decimal(20,2) NOT NULL DEFAULT '0.00',
  `default_sell_price` decimal(20,2) DEFAULT NULL,
  `sell_price_inc_tax` decimal(20,2) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `variations_product_id_foreign` (`product_id`),
  KEY `variations_product_variation_id_foreign` (`product_variation_id`),
  KEY `variations_name_index` (`name`),
  KEY `variations_sub_sku_index` (`sub_sku`),
  KEY `variations_variation_value_id_index` (`variation_value_id`),
  CONSTRAINT `variations_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  CONSTRAINT `variations_product_variation_id_foreign` FOREIGN KEY (`product_variation_id`) REFERENCES `product_variations` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla inventory.variations: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `variations` DISABLE KEYS */;
/*!40000 ALTER TABLE `variations` ENABLE KEYS */;

-- Volcando estructura para tabla inventory.variation_group_prices
CREATE TABLE IF NOT EXISTS `variation_group_prices` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `variation_id` int(10) unsigned NOT NULL,
  `price_group_id` int(10) unsigned NOT NULL,
  `price_inc_tax` decimal(20,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `variation_group_prices_variation_id_foreign` (`variation_id`),
  KEY `variation_group_prices_price_group_id_foreign` (`price_group_id`),
  CONSTRAINT `variation_group_prices_price_group_id_foreign` FOREIGN KEY (`price_group_id`) REFERENCES `selling_price_groups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `variation_group_prices_variation_id_foreign` FOREIGN KEY (`variation_id`) REFERENCES `variations` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla inventory.variation_group_prices: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `variation_group_prices` DISABLE KEYS */;
/*!40000 ALTER TABLE `variation_group_prices` ENABLE KEYS */;

-- Volcando estructura para tabla inventory.variation_location_details
CREATE TABLE IF NOT EXISTS `variation_location_details` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `product_id` int(10) unsigned NOT NULL,
  `product_variation_id` int(10) unsigned NOT NULL COMMENT 'id from product_variations table',
  `variation_id` int(10) unsigned NOT NULL,
  `location_id` int(10) unsigned NOT NULL,
  `qty_available` decimal(20,4) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `variation_location_details_location_id_foreign` (`location_id`),
  KEY `variation_location_details_product_id_index` (`product_id`),
  KEY `variation_location_details_product_variation_id_index` (`product_variation_id`),
  KEY `variation_location_details_variation_id_index` (`variation_id`),
  CONSTRAINT `variation_location_details_location_id_foreign` FOREIGN KEY (`location_id`) REFERENCES `business_locations` (`id`),
  CONSTRAINT `variation_location_details_variation_id_foreign` FOREIGN KEY (`variation_id`) REFERENCES `variations` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla inventory.variation_location_details: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `variation_location_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `variation_location_details` ENABLE KEYS */;

-- Volcando estructura para tabla inventory.variation_templates
CREATE TABLE IF NOT EXISTS `variation_templates` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `business_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `variation_templates_business_id_foreign` (`business_id`),
  CONSTRAINT `variation_templates_business_id_foreign` FOREIGN KEY (`business_id`) REFERENCES `business` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla inventory.variation_templates: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `variation_templates` DISABLE KEYS */;
/*!40000 ALTER TABLE `variation_templates` ENABLE KEYS */;

-- Volcando estructura para tabla inventory.variation_value_templates
CREATE TABLE IF NOT EXISTS `variation_value_templates` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `variation_template_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `variation_value_templates_name_index` (`name`),
  KEY `variation_value_templates_variation_template_id_index` (`variation_template_id`),
  CONSTRAINT `variation_value_templates_variation_template_id_foreign` FOREIGN KEY (`variation_template_id`) REFERENCES `variation_templates` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla inventory.variation_value_templates: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `variation_value_templates` DISABLE KEYS */;
/*!40000 ALTER TABLE `variation_value_templates` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
