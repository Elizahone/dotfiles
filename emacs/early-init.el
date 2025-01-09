;; -*- lexical-binding: t no-byte-compile: t -*-

;; -*- lexical-binding: t -*-
 (setq gc-cons-threshold most-positive-fixnum)
 (setq gc-cons-percentage 0.6)
 (setq native-comp-deferred-compilation nil ;; obsolete since 29.1
   native-comp-jit-compilation nil)

 (setq load-prefer-newer noninteractive)
 (when (getenv-internal "DEBUG")
   (setq init-file-debug t
	 debug-on-error t))

 (setq package-enable-at-startup nil)
 (setq use-package-enable-imenu-support t)

 (setq load-prefer-newer noninteractive)

 (setq frame-inhibit-implied-resize t)

;; Faster to disable these here (before they've been initialized)
 (push '(menu-bar-lines . 0) default-frame-alist)
 (push '(tool-bar-lines . 0) default-frame-alist)
 (push '(vertical-scroll-bars) default-frame-alist)
 (when (featurep 'ns)
   (push '(ns-transparent-titlebar . t) default-frame-alist))
 ;; (setq-default mode-line-format nil)
