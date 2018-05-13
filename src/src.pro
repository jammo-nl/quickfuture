TARGET = quickfuture
TEMPLATE = lib

isEmpty(SHARED): SHARED = "false"
isEmpty(PLUGIN): PLUGIN = "false"

DEFAULT_INSTALL_ROOT = $$[QT_INSTALL_LIBS]

isEmpty(INSTALL_ROOT) {
    INSTALL_ROOT = $${DEFAULT_INSTALL_ROOT}
}

include(../quickfuture.pri)

INSTALLS += target

equals(PLUGIN, "true") {
    SHARED = "true"
    TARGET = quickfutureqmlplugin
    CONFIG         += plugin
    DEFINES += QUICK_FUTURE_BUILD_PLUGIN
    isEmpty(INSTALL_ROOT): INSTALL_ROOT=$$[QT_INSTALL_QML]

    target.path = $${INSTALL_ROOT}/QuickFuture

    QML.files = $$PWD/qmldir
    QML.path = $${INSTALL_ROOT}/QuickFuture

    INSTALLS += QML

} else {
    isEmpty(INSTALL_ROOT): INSTALL_ROOT=$$[QT_INSTALL_LIBS]

    headers.files += \
        $$PWD/qfvariantwrapper.h \
        $$PWD/qffuture.h \
        $$PWD/QuickFuture \
        $$PWD/quickfuture.h

    target.path = $${INSTALL_ROOT}/lib
    INSTALLS += headers

    headers.path = $${INSTALL_ROOT}/include
}

equals(SHARED, "false") {
    CONFIG += staticlib
}
