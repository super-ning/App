package com.app.hl7.task;

import com.app.hl7.Hl7ComonConfig;
import com.app.hl7.NtpUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Component
public class SyncTimeFromNtp extends Thread{
    private static final Logger logger = LoggerFactory.getLogger(SyncTimeFromNtp.class);

//    @Scheduled(cron = Hl7ComonConfig.DATE_SYNC_CRON)
    public String execute() {
        if (!Hl7ComonConfig.ENABLE_CT_SYNC){
            return null;
        }
        if (!NtpUtil.getOsType().equalsIgnoreCase("MAC")){
            return null;
        }
        try {
            Process process = null;
            String shpath = Hl7ComonConfig.DATE_SYNC_SH_FILE_PATH + Hl7ComonConfig.DATE_SYNC_ADDRESS;
            String command = "/bin/sh " + shpath;
            List<String> processList = new ArrayList<String>();
            process = Runtime.getRuntime().exec(command);
            BufferedReader input = new BufferedReader(new InputStreamReader(process.getInputStream()));
            String line = "";
            while ((line = input.readLine()) != null) {
                processList.add(line);
            }
            input.close();
            if (processList.size() >= 3){
                logger.info(processList.get(2));
                return processList.get(2);
            }
        } catch (Throwable e) {
            logger.error("execute ntp server sync date find fail, now date is {}", new Date());
        }
        logger.info("execute ntp server sync date is success , now date is {}", new Date());
        return null;
    }

    public String execute(String address) {
        if (!Hl7ComonConfig.ENABLE_CT_SYNC){
            return null;
        }
        if (!NtpUtil.getOsType().equalsIgnoreCase("MAC")){
            return null;
        }
        try {
            Process process = null;
            String shpath = Hl7ComonConfig.DATE_SYNC_SH_FILE_PATH + address;
            String command = "/bin/sh " + shpath;
            List<String> processList = new ArrayList<String>();
            process = Runtime.getRuntime().exec(command);
            BufferedReader input = new BufferedReader(new InputStreamReader(process.getInputStream()));
            String line = "";
            while ((line = input.readLine()) != null) {
                processList.add(line);
            }
            input.close();
            if (processList.size() >= 3){
                logger.info(processList.get(2));
                return processList.get(2);
            }
        } catch (Throwable e) {
            logger.error("execute ntp server sync date find fail, now date is {}", new Date());
        }
        logger.info("execute ntp server sync date is success , now date is {}", new Date());
        return null;
    }
}