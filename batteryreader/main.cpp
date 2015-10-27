/*
 * Copyright (c) 2015, Robin Burchell <robin@viroteck.net>
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 * * Redistributions of source code must retain the above copyright notice, this
 *   list of conditions and the following disclaimer.
 *
 * * Redistributions in binary form must reproduce the above copyright notice,
 *   this list of conditions and the following disclaimer in the documentation
 *   and/or other materials provided with the distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
 * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
 * OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#define LOG_TAG "batteryreader"

#include <batteryservice/IBatteryPropertiesListener.h>
#include <batteryservice/IBatteryPropertiesRegistrar.h>

#include <binder/IPCThreadState.h>
#include <binder/ProcessState.h>
#include <binder/IServiceManager.h>

namespace android {
class MyBatteryPropertiesListener : public BpInterface<IBatteryPropertiesListener>
{
public:
    MyBatteryPropertiesListener(const sp<IBinder>& impl)
        : BpInterface<IBatteryPropertiesListener>(impl)
    {
    }
    void batteryPropertiesChanged(struct BatteryProperties props)
    {
        ALOGI("Battery properties changed");
    }
};
}

int main(int argc, char **argv)
{
    ALOGI("Starting up");

    android::sp<android::IServiceManager> sm = android::defaultServiceManager();
    android::sp<android::IBinder> binder;

    do {
        binder = sm->getService(android::String16("batteryproperties"));
        if (binder != 0)
            break;
        ALOGW("No battery service found, waiting");
        usleep(500000);
    } while (true);

    android::sp<android::IBatteryPropertiesRegistrar> bpr = android::interface_cast<android::IBatteryPropertiesRegistrar>(binder);
    android::sp<android::IBatteryPropertiesListener> mbl = new android::MyBatteryPropertiesListener(binder /* should this be bpr? */);

    bpr->registerListener(mbl);

    android::ProcessState::self()->startThreadPool();
    android::IPCThreadState::self()->joinThreadPool();
    return 0;
}

