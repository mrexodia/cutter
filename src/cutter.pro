TEMPLATE = app

TARGET = cutter

# The application version
win32 {
    VERSION = 1.0
    # Generate debug symbols in release mode
    QMAKE_CXXFLAGS_RELEASE += -Zi   # Compiler
    QMAKE_LFLAGS_RELEASE += /DEBUG  # Linker
} else {
    VERSION = 1.0-dev
}

ICON = img/Enso.icns

QT += core gui widgets webengine webenginewidgets

QT_CONFIG -= no-pkg-config

CONFIG += c++11

# Define the preprocessor macro to get the application version in our application.
DEFINES += APP_VERSION=\\\"$$VERSION\\\"

macx {
    QMAKE_CXXFLAGS = -mmacosx-version-min=10.7 -std=gnu0x -stdlib=libc++
}

INCLUDEPATH *= .

unix:exists(/usr/local/include/libr) {
    INCLUDEPATH += /usr/local/include/libr
}

SOURCES += \
    main.cpp \
    mainwindow.cpp \
    newfiledialog.cpp \
    optionsdialog.cpp \
    highlighter.cpp \
    cutter.cpp \
    createnewdialog.cpp \
    hexascii_highlighter.cpp \
    widgets/pieview.cpp \
    widgets/sectionswidget.cpp \
    widgets/codegraphic.cpp \
    widgets/notepad.cpp \
    mdhighlighter.cpp \
    widgets/functionswidget.cpp \
    dialogs/renamedialog.cpp \
    dialogs/aboutdialog.cpp \
    widgets/importswidget.cpp \
    widgets/symbolswidget.cpp \
    widgets/relocswidget.cpp \
    widgets/commentswidget.cpp \
    widgets/stringswidget.cpp \
    widgets/flagswidget.cpp \
    widgets/memorywidget.cpp \
    widgets/exportswidget.cpp \
    widgets/sdbdock.cpp \
    analthread.cpp \
    dialogs/commentsdialog.cpp \
    widgets/sidebar.cpp \
    helpers.cpp \
    widgets/omnibar.cpp \
    widgets/dashboard.cpp \
    dialogs/xrefsdialog.cpp \
    hexhighlighter.cpp \
    widgets/sectionsdock.cpp \
    widgets/consolewidget.cpp \
    radarewebserver.cpp \
    widgets/entrypointwidget.cpp \
    dialogs/flagdialog.cpp

HEADERS  += \
    mainwindow.h \
    newfiledialog.h \
    optionsdialog.h \
    highlighter.h \
    createnewdialog.h \
    hexascii_highlighter.h \
    widgets/pieview.h \
    widgets/sectionswidget.h \
    widgets/codegraphic.h \
    widgets/notepad.h \
    mdhighlighter.h \
    widgets/functionswidget.h \
    dialogs/renamedialog.h \
    dialogs/aboutdialog.h \
    widgets/importswidget.h \
    widgets/symbolswidget.h \
    widgets/relocswidget.h \
    widgets/commentswidget.h \
    widgets/stringswidget.h \
    widgets/flagswidget.h \
    widgets/memorywidget.h \
    widgets/exportswidget.h \
    widgets/sdbdock.h \
    analthread.h \
    dialogs/commentsdialog.h \
    widgets/sidebar.h \
    helpers.h \
    widgets/omnibar.h \
    widgets/dashboard.h \
    dialogs/xrefsdialog.h \
    hexhighlighter.h \
    widgets/sectionsdock.h \
    widgets/dockwidget.h \
    widgets/consolewidget.h \
    radarewebserver.h \
    settings.h \
    widgets/entrypointwidget.h \
    cutter.h \
    dialogs/flagdialog.h
FORMS    += \
    mainwindow.ui \
    newfiledialog.ui \
    optionsdialog.ui \
    createnewdialog.ui \
    widgets/notepad.ui \
    widgets/functionswidget.ui \
    dialogs/aboutdialog.ui \
    dialogs/renamedialog.ui \
    widgets/importswidget.ui \
    widgets/symbolswidget.ui \
    widgets/relocswidget.ui \
    widgets/commentswidget.ui \
    widgets/stringswidget.ui \
    widgets/flagswidget.ui \
    widgets/memorywidget.ui \
    widgets/exportswidget.ui \
    widgets/sdbdock.ui \
    dialogs/commentsdialog.ui \
    widgets/sidebar.ui \
    widgets/dashboard.ui \
    dialogs/xrefsdialog.ui \
    widgets/sectionsdock.ui \
    widgets/consolewidget.ui \
    widgets/entrypointwidget.ui \
    dialogs/flagdialog.ui

RESOURCES += \
    resources.qrc

DISTFILES += cutter.astylerc


include(lib_radare2.pri)


# 'make install' for AppImage
unix {
    isEmpty(PREFIX) {
        PREFIX = /usr/local
    }

    icon_file = img/cutter-small.png

    share_pixmaps.path = $$PREFIX/share/pixmaps
    share_pixmaps.files = $$icon_file


    desktop_file = cutter.desktop

    # built-in no need for files atm
    target.path = $$PREFIX/bin

    share_applications.path = $$PREFIX/share/applications
    share_applications.files = $$desktop_file

    INSTALLS += target share_applications share_pixmaps

    # Triggered for example by 'qmake APPIMAGE=1'
    !isEmpty(APPIMAGE){
        # UGLY work around for the logo name in cutter.desktop
        # Would be better to have a file called cutter.png in the first place
        system(cp img/cutter-small.png $$OUT_PWD/cutter-small.png)

        appimage_root.path = /
        appimage_root.files = $$OUT_PWD/cutter.png $$desktop_file

        INSTALLS += appimage_root
    }
}
