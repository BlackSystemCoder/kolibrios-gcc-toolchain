CMAKE_MINIMUM_REQUIRED(VERSION 2.8.12)

project(
	KolibriOS-gcc-Toolchain-installer
	DESCRIPTION "Installer of gcc toolchain for KolibriOS"
)

add_custom_target(
	download_libraries
	COMMAND mkdir -p ${CMAKE_CURRENT_BINARY_DIR}/libs
	COMMAND wget http://ftp.kolibrios.org/users/Serge/new/Toolchain/sdk-28-10-16.7z -q -O ${CMAKE_CURRENT_BINARY_DIR}/libs/sdk-28-10-16.7z
	COMMAND wget -r --no-parent -q http://builds.kolibrios.org/en_US/data/contrib/sdk/lib -O ${CMAKE_CURRENT_BINARY_DIR}/libs/builds.kolibrios.org
	COMMAND 7z x -y ${CMAKE_CURRENT_BINARY_DIR}/libs/sdk-28-10-16.7z
	COMMAND mv ${CMAKE_CURRENT_BINARY_DIR}/libs/builds.kolibrios.org/en_US/data/contrib/sdk/lib/* ${CMAKE_CURRENT_BINARY_DIR}/libs
	COMMAND rm -R ${CMAKE_CURRENT_BINARY_DIR}/libs/builds.kolibrios.org
	COMMENT "Download libraries"
)

add_custom_target(
	download_linux
	COMMAND wget http://ftp.kolibrios.org/users/Serge/new/Toolchain/x86_64-linux-kos32-5.4.0.7z -q -O ${CMAKE_CURRENT_BINARY_DIR}/kos32-toolchain-linux.7z
	COMMAND wget http://board.kolibrios.org/download/file.php?id=8301libisl.so.10.2.2.7z -q -O ${CMAKE_CURRENT_BINARY_DIR}/libisl.so.10.2.2.7z
	WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
	COMMENT "Download linux toolchain"
)

add_custom_target(
	download_windows
	COMMAND wget http://ftp.kolibrios.org/users/Serge/new/Toolchain/msys-kos32-5.4.0.7z -q -O ${CMAKE_CURRENT_BINARY_DIR}/kos32-toolchain-win.7z
	COMMENT "Download windows toolchain"
	WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
)

add_custom_target(
	deb
	COMMAND mkdir -p ${CMAKE_CURRENT_SOURCE_DIR}/package/usr/lib/x86_64-linux-gnu
	COMMAND cp -f ${CMAKE_CURRENT_SOURCE_DIR}/install.sh ${CMAKE_CURRENT_SOURCE_DIR}/package/DEBIAN/postinst
	COMMAND cp -f ${CMAKE_CURRENT_SOURCE_DIR}/LICENSE ${CMAKE_CURRENT_SOURCE_DIR}/package/DEBIAN/copyright
	COMMAND 7z x ${CMAKE_CURRENT_BINARY_DIR}/libisl.so.10.2.2.7z -o ${CMAKE_CURRENT_SOURCE_DIR}/package/usr/lib/x86_64-linux-gnu/libisl.so.10.2.2
	COMMAND chmod 775 ${CMAKE_CURRENT_SOURCE_DIR}/package/DEBIAN
	COMMAND chmod 775 ${CMAKE_CURRENT_SOURCE_DIR}/package/DEBIAN/control
	COMMAND chmod 775 ${CMAKE_CURRENT_SOURCE_DIR}/package/DEBIAN/prerm
	COMMAND chmod 775 ${CMAKE_CURRENT_SOURCE_DIR}/package/DEBIAN/postinst
	COMMAND chmod 775 ${CMAKE_CURRENT_SOURCE_DIR}/package/DEBIAN/postrm
	COMMAND chmod 775 ${CMAKE_CURRENT_SOURCE_DIR}/package/DEBIAN/copyright
	COMMAND dpkg-deb --build ${CMAKE_CURRENT_SOURCE_DIR}/package ${CMAKE_CURRENT_BINARY_DIR}/package.deb
	WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
	COMMENT "Build deb package"
	SOURCES 
	${CMAKE_CURRENT_SOURCE_DIR}/install.sh 
	${CMAKE_CURRENT_SOURCE_DIR}/LICENSE 
	${CMAKE_CURRENT_SOURCE_DIR}/package/DEBIAN/control
	${CMAKE_CURRENT_SOURCE_DIR}/package/DEBIAN/postrm
)

add_custom_target(
	Installer
	COMMAND 7z x ${CMAKE_CURRENT_BINARY_DIR}/kos32-toolchain-win.7z -o ${CMAKE_CURRENT_BINARY_DIR}
	COMMAND iscc /O"${CMAKE_CURRENT_BINARY_DIR}" ${CMAKE_CURRENT_SOURCE_DIR}/installator.iss 
	COMMENT "Build windows installer"
	WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
	SOURCES
	${CMAKE_CURRENT_SOURCE_DIR}/installator.iss
	${CMAKE_CURRENT_SOURCE_DIR}/LICENSE
	${CMAKE_CURRENT_SOURCE_DIR}/README.md
)

add_custom_target(
	choco
	COMMAND cp -f ${CMAKE_CURRENT_BINARY_DIR}/kos32-toolchain-win.7z ${CMAKE_CURRENT_SOURCE_DIR}/chocolatey/tools
	COMMAND choco pack
	WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/chocolatey
	COMMENT "Build chocolatey package"
)

add_dependencies(
	deb 
	download_linux
)

add_dependencies(
	choco
	download_windows
)

add_dependencies(
	Installer
	download_windows
)
