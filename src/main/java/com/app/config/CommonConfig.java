package com.app.config;

import com.app.rest.DefaultRestPackage;

/**
 * 通用默认配置类
 * 由于配置文件properties为配置需要经常改动的配置属性
 * 而相对很稳定的配置执直接在代码中向内存中读取，在此基础之上，
 * 优化了，配置的获取方式，在进行代码重构的过程中依然能够自动配置
 */
public class CommonConfig {
    public static final String BASE_PATH = "/";
    public static final String SCAN_REST_PACKAGE = DefaultRestPackage.name;
    public static final boolean ENABLE_WEB_SERVER = false;
    public static final boolean LOCAL_DEV_ONALY_FORWARD = true;
}
