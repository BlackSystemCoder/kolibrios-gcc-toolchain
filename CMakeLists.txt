CMAKE_MINIMUM_REQUIRED(VERSION 2.8.12)

project(
	KolibriOS-gcc-Toolchain-installer
	DESCRIPTION "Installer of gcc toolchain for KolibriOS"
)


add_custom_target(
	deb
	COMMAND cp -f ${CMAKE_CURRENT_SOURCE_DIR}/install.sh ${CMAKE_CURRENT_SOURCE_DIR}/package/DEBIAN/postinst
	COMMAND cp -f ${CMAKE_CURRENT_SOURCE_DIR}/LICENSE ${CMAKE_CURRENT_SOURCE_DIR}/package/DEBIAN/copyright
	COMMAND chmod 775 ${CMAKE_CURRENT_SOURCE_DIR}/package/DEBIAN
	COMMAND chmod 775 ${CMAKE_CURRENT_SOURCE_DIR}/package/DEBIAN/control
	COMMAND chmod 775 ${CMAKE_CURRENT_SOURCE_DIR}/package/DEBIAN/prerm
	COMMAND chmod 775 ${CMAKE_CURRENT_SOURCE_DIR}/package/DEBIAN/postinst
	COMMAND chmod 775 ${CMAKE_CURRENT_SOURCE_DIR}/package/DEBIAN/postrm
	COMMAND chmod 775 ${CMAKE_CURRENT_SOURCE_DIR}/package/DEBIAN/copyright
	COMMAND dpkg-deb --build ${CMAKE_CURRENT_SOURCE_DIR}/package ${CMAKE_CURRENT_BINARY_DIR}/package.deb
	WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
	COMMENT "Build deb package"
)

add_custom_target(
	Installer
	COMMAND iscc /O"${CMAKE_CURRENT_BINARY_DIR}" ${CMAKE_CURRENT_SOURCE_DIR}/installator.iss 
	COMMENT "Build windows installer"
)

add_custom_target(
	choco
	COMMAND cp -f ${CMAKE_CURRENT_SOURCE_DIR}/install.ps1 ${CMAKE_CURRENT_SOURCE_DIR}/chocolatey/tools
	COMMAND choco pack
	WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/chocolatey
	COMMENT "Build chocolatey package"
)
