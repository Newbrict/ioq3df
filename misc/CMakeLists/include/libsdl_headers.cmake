# The MIT License (MIT)
# 
# Copyright (c) 2015 github.com/Pan7
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
# 
set(LIBSDL_HEADERS 
	"${LIBSDL_DIR}/include/begin_code.h"
	"${LIBSDL_DIR}/include/close_code.h"
	"${LIBSDL_DIR}/include/SDL.h"
	"${LIBSDL_DIR}/include/SDL_assert.h"
	"${LIBSDL_DIR}/include/SDL_atomic.h"
	"${LIBSDL_DIR}/include/SDL_audio.h"
	"${LIBSDL_DIR}/include/SDL_bits.h"
	"${LIBSDL_DIR}/include/SDL_blendmode.h"
	"${LIBSDL_DIR}/include/SDL_clipboard.h"
	"${LIBSDL_DIR}/include/SDL_config.h"
	"${LIBSDL_DIR}/include/SDL_config_android.h"
	"${LIBSDL_DIR}/include/SDL_config_iphoneos.h"
	"${LIBSDL_DIR}/include/SDL_config_macosx.h"
	"${LIBSDL_DIR}/include/SDL_config_minimal.h"
	"${LIBSDL_DIR}/include/SDL_config_pandora.h"
	"${LIBSDL_DIR}/include/SDL_config_psp.h"
	"${LIBSDL_DIR}/include/SDL_config_windows.h"
	"${LIBSDL_DIR}/include/SDL_config_winrt.h"
	"${LIBSDL_DIR}/include/SDL_config_wiz.h"
	"${LIBSDL_DIR}/include/SDL_copying.h"
	"${LIBSDL_DIR}/include/SDL_cpuinfo.h"
	"${LIBSDL_DIR}/include/SDL_egl.h"
	"${LIBSDL_DIR}/include/SDL_endian.h"
	"${LIBSDL_DIR}/include/SDL_error.h"
	"${LIBSDL_DIR}/include/SDL_events.h"
	"${LIBSDL_DIR}/include/SDL_filesystem.h"
	"${LIBSDL_DIR}/include/SDL_gamecontroller.h"
	"${LIBSDL_DIR}/include/SDL_gesture.h"
	"${LIBSDL_DIR}/include/SDL_haptic.h"
	"${LIBSDL_DIR}/include/SDL_hints.h"
	"${LIBSDL_DIR}/include/SDL_joystick.h"
	"${LIBSDL_DIR}/include/SDL_keyboard.h"
	"${LIBSDL_DIR}/include/SDL_keycode.h"
	"${LIBSDL_DIR}/include/SDL_loadso.h"
	"${LIBSDL_DIR}/include/SDL_log.h"
	"${LIBSDL_DIR}/include/SDL_main.h"
	"${LIBSDL_DIR}/include/SDL_messagebox.h"
	"${LIBSDL_DIR}/include/SDL_mouse.h"
	"${LIBSDL_DIR}/include/SDL_mutex.h"
	"${LIBSDL_DIR}/include/SDL_name.h"
	"${LIBSDL_DIR}/include/SDL_opengl.h"
	"${LIBSDL_DIR}/include/SDL_opengles.h"
	"${LIBSDL_DIR}/include/SDL_opengles2.h"
	"${LIBSDL_DIR}/include/SDL_pixels.h"
	"${LIBSDL_DIR}/include/SDL_platform.h"
	"${LIBSDL_DIR}/include/SDL_power.h"
	"${LIBSDL_DIR}/include/SDL_quit.h"
	"${LIBSDL_DIR}/include/SDL_rect.h"
	"${LIBSDL_DIR}/include/SDL_render.h"
	"${LIBSDL_DIR}/include/SDL_revision.h"
	"${LIBSDL_DIR}/include/SDL_rwops.h"
	"${LIBSDL_DIR}/include/SDL_scancode.h"
	"${LIBSDL_DIR}/include/SDL_shape.h"
	"${LIBSDL_DIR}/include/SDL_stdinc.h"
	"${LIBSDL_DIR}/include/SDL_surface.h"
	"${LIBSDL_DIR}/include/SDL_system.h"
	"${LIBSDL_DIR}/include/SDL_syswm.h"
	"${LIBSDL_DIR}/include/SDL_test.h"
	"${LIBSDL_DIR}/include/SDL_test_assert.h"
	"${LIBSDL_DIR}/include/SDL_test_common.h"
	"${LIBSDL_DIR}/include/SDL_test_compare.h"
	"${LIBSDL_DIR}/include/SDL_test_crc32.h"
	"${LIBSDL_DIR}/include/SDL_test_font.h"
	"${LIBSDL_DIR}/include/SDL_test_fuzzer.h"
	"${LIBSDL_DIR}/include/SDL_test_harness.h"
	"${LIBSDL_DIR}/include/SDL_test_images.h"
	"${LIBSDL_DIR}/include/SDL_test_log.h"
	"${LIBSDL_DIR}/include/SDL_test_md5.h"
	"${LIBSDL_DIR}/include/SDL_test_random.h"
	"${LIBSDL_DIR}/include/SDL_thread.h"
	"${LIBSDL_DIR}/include/SDL_timer.h"
	"${LIBSDL_DIR}/include/SDL_touch.h"
	"${LIBSDL_DIR}/include/SDL_types.h"
	"${LIBSDL_DIR}/include/SDL_version.h"
	"${LIBSDL_DIR}/include/SDL_video.h"
)
