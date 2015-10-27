TEMPLATE = app
SOURCES = main.cpp

QT -= gui
LIBS += -lcutils -lbinder -lutils
LIBS += -L$$(ANDROID_PRODUCT_OUT)/obj/STATIC_LIBRARIES/libbatteryservice_intermediates
LIBS += -lbatteryservice
