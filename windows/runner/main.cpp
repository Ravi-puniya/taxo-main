#include <flutter/dart_project.h>
#include <flutter/flutter_view_controller.h>
#include <windows.h>

#include "flutter_window.h"
#include "utils.h"

int APIENTRY wWinMain(_In_ HINSTANCE instance, _In_opt_ HINSTANCE prev,
                      _In_ wchar_t *command_line, _In_ int show_command) {
  // Attach to console when present (e.g., 'flutter run') or create a
  // new console when running with a debugger.
  if (!::AttachConsole(ATTACH_PARENT_PROCESS) && ::IsDebuggerPresent()) {
    CreateAndAttachConsole();
  }

  // Initialize COM, so that it is available for use in the library and/or
  // plugins.
  ::CoInitializeEx(nullptr, COINIT_APARTMENTTHREADED);

  flutter::DartProject project(L"data");

  std::vector<std::string> command_line_arguments =
      GetCommandLineArguments();

  project.set_dart_entrypoint_arguments(std::move(command_line_arguments));

  FlutterWindow window(project);

  // Obtener el tamaño de la pantalla
  RECT desktopRect;
  GetWindowRect(GetDesktopWindow(), &desktopRect);
  int screenWidth = desktopRect.right - desktopRect.left;
  int screenHeight = desktopRect.bottom - desktopRect.top;

  // Definir las dimensiones deseadas para una vista de celular
  int cellScreenWidth = 480; // Ancho de la pantalla de un celular
  int cellScreenHeight = 840; // Alto de la pantalla de un celular

  // Calcular la posición para centrar la ventana
  int windowX = (screenWidth - cellScreenWidth) / 2;
  int windowY = (screenHeight - cellScreenHeight) / 2;

  Win32Window::Point origin(windowX, windowY);
  Win32Window::Size size(cellScreenWidth, cellScreenHeight);

  if (!window.CreateAndShow(L"taxo", origin, size)) {
    return EXIT_FAILURE;
  }
  window.SetQuitOnClose(true);

  ::MSG msg;
  while (::GetMessage(&msg, nullptr, 0, 0)) {
    ::TranslateMessage(&msg);
    ::DispatchMessage(&msg);
  }

  ::CoUninitialize();
  return EXIT_SUCCESS;
}
