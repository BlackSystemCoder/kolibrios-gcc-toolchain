CMAKE_MINIMUM_REQUIRED(VERSION 3.10)

project(
	KolibriOS-gcc-Toolchain-installer
	DESCRIPTION "Installer of gcc toolchain for KolibriOS"
)


add_custom_target(
	Package
	COMMAND cp -f ${CMAKE_CURRENT_SOURCE_DIR}/install.sh ${CMAKE_CURRENT_SOURCE_DIR}/package/DEBIAN/postinst
	COMMAND chmod 775 ${CMAKE_CURRENT_SOURCE_DIR}/package/DEBIAN
	COMMAND chmod 775 ${CMAKE_CURRENT_SOURCE_DIR}/package/DEBIAN/control
	COMMAND chmod 775 ${CMAKE_CURRENT_SOURCE_DIR}/package/DEBIAN/prerm
	COMMAND chmod 775 ${CMAKE_CURRENT_SOURCE_DIR}/package/DEBIAN/postinst
	COMMAND chmod 775 ${CMAKE_CURRENT_SOURCE_DIR}/package/DEBIAN/postrm
	COMMAND dpkg-deb --build ${CMAKE_CURRENT_SOURCE_DIR}/package ${CMAKE_CURRENT_BINARY_DIR}/package.deb
	WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
)

add_custom_target(
	Installer
	COMMAND iscc /O"${CMAKE_CURRENT_BINARY_DIR}" ${CMAKE_CURRENT_SOURCE_DIR}/installator.iss 
)
