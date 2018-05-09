package com.app.dtu.task;

import com.app.dtu.bean.model.DeviceRelation;
import com.app.dtu.bean.model.DeviceSnid;
import com.app.dtu.config.DtuConfig;
import com.app.dtu.repository.DeviceSnidReponsitory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.util.CollectionUtils;

import java.util.ArrayList;
import java.util.List;

@Configuration
public class ScheduleUpdateLocalCache {
    private static final Logger logger = LoggerFactory.getLogger(ScheduleUpdateLocalCache.class);
    @Autowired
    private DeviceSnidReponsitory deviceSnidReponsitory;

    /**
     * 每一小时执行一次更新操作，更新本地缓存
     * 获取到设备id，sn，型号码
     */
    @Scheduled(cron = DtuConfig.LOCAL_CACHE_CRON)
    public void updateDeviceModelCode() {
        // 如果启动debug模式，会直接读取本地的初始化缓存，这里是不获取本地缓存的
        if (DtuConfig.ENABLE_BUBUG_MODE){
            return;
        }
        List<DeviceRelation> deviceRelations = new ArrayList<>();
        List<DeviceSnid> deviceSnids = deviceSnidReponsitory.findAll();
        if (CollectionUtils.isEmpty(deviceSnids)) {
            logger.warn("Update device model code local cache is error, total num is {}", LocalCache.getDeviceRelationCache().size());
            return;
        }
        deviceSnids.stream().forEach(deviceSnid -> {
            DeviceRelation deviceRelation = new DeviceRelation();
            deviceRelation.setDevice_id(deviceSnid.getSiid());
            deviceRelation.setDevice_sn(deviceSnid.getSisn());
            if (null != deviceSnid.getSisn() && deviceSnid.getSisn().length() == 17) {
                deviceRelation.setDevice_model_code(deviceSnid.getSisn().substring(9, 13));
            }
            deviceRelations.add(deviceRelation);
        });
        if (!CollectionUtils.isEmpty(deviceRelations)) {
            LocalCache.updateDeviceRelation(deviceRelations);
        }
        logger.info("Update device model code local cache is success, total num is {}", LocalCache.getDeviceRelationCache().size());
    }
}