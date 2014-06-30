/* 
 * This is a Jinja2 template for generating the C source file for a propnet game implementation.
 */
typedef struct {
    {% for field in bitfields %}
        unsigned in {{ field }}
    {% endfor %}
} {{ game.name }};
