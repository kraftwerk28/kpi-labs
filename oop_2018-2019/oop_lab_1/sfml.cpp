#include <SFML/Window.hpp>
#include <SFML/Graphics.hpp>

using namespace sf;

void sfify() {
    const int w = 400, h = 400;
    bool mPressed = false;

    Texture texture;
    texture.create(w, h);
    Sprite sprite;
    sprite.setTexture(texture);

    auto *pix_arr = new Uint8[w * h * 4]; // rgba

    auto *vm = new VideoMode(400, 400);
    RenderWindow *win = new RenderWindow(VideoMode(400, 400), "Hello there");

    for (int i = 0; i < w * h * 4; i += 4) {
        pix_arr[i] = 0;
        pix_arr[i + 1] = 0;
        pix_arr[i + 2] = 0;
        pix_arr[i + 3] = 255;
    }
    texture.update(pix_arr);

    Event evt;
    while (win->isOpen()) {
        while (win->pollEvent(evt)) {
            if (evt.type == Event::Closed) {
                win->close();
            }

            if (evt.type == Event::MouseButtonPressed) {
                if (evt.mouseButton.button == 0) {
                    mPressed = true;
                }
            }

            if (evt.type == Event::MouseButtonReleased) {
                if (evt.mouseButton.button == 0) {
                    mPressed = false;
                }
            }

            if (evt.type == Event::MouseMoved) {
                if (mPressed) {
                    const int v = evt.mouseMove.x * 4 + evt.mouseMove.y * w * 4;
                    pix_arr[v] = 255;
                    pix_arr[v + 1] = 255;
                    texture.update(pix_arr);
                }
            }
        }

        win->draw(sprite);
        win->display();
    }
}