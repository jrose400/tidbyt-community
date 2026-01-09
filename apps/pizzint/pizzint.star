load("render.star", "render")
load("http.star", "http")

# Display dimensions
DISPLAY_WIDTH = 64
DISPLAY_HEIGHT = 32
PIZZA_WIDTH = 28
DEFCON_WIDTH = 36
TOP_SECTION_HEIGHT = 24
CONTENT_HEIGHT = 21
TEXT_HEIGHT = 6
SPACER_HEIGHT = 1

# Colors
BG_COLOR = "#140A05"
SPACER_COLOR = "#000000"
PIZZA_CRUST_COLOR = "#FFC800"
PIZZA_SAUCE_COLOR = "#8B4513"
PIZZA_PEPPERONI_COLOR = "#FFFF00"

# Scrolling text constants
CHAR_WIDTH = 6
SCROLL_SPEED = 1
SCROLL_PADDING = "    "

def rgb_to_hex(r, g, b):
    """Convert RGB values to hex color string"""
    def to_hex(n):
        digits = "0123456789ABCDEF"
        d1 = digits[n // 16]
        d2 = digits[n % 16]
        return d1 + d2
    return "#" + to_hex(r) + to_hex(g) + to_hex(b)

def get_defcon_color(level):
    """Returns hex color string based on DEFCON level"""
    if level == None or level < 1 or level > 5:
        level = 3
    
    if level == 1:
        return rgb_to_hex(255, 51, 51)
    elif level == 2:
        return rgb_to_hex(255, 128, 0)
    elif level == 3:
        return rgb_to_hex(255, 255, 0)
    elif level == 4:
        return rgb_to_hex(0, 255, 255)
    elif level == 5:
        return rgb_to_hex(0, 128, 255)
    else:
        return rgb_to_hex(255, 255, 0)

def get_status_text_for_level(level):
    """Get the status text that matches the site's DEFCON level mapping"""
    if level == None or level < 1 or level > 5:
        return "MONITORING PIZZA FREQUENCIES"
    
    if level == 1:
        return "EXERCISE TERM - MAXIMUM READINESS"
    elif level == 2:
        return "FAST PACE - NEXT STEP TO MAXIMUM READINESS"
    elif level == 3:
        return "ROUND HOUSE - INCREASE IN FORCE READINESS"
    elif level == 4:
        return "DOUBLE TAKE - INCREASED INTELLIGENCE WATCH"
    elif level == 5:
        return "FADE OUT - LOWEST STATE OF READINESS"
    else:
        return "MONITORING PIZZA FREQUENCIES"

def fetch_defcon_data():
    """Fetch and parse DEFCON data from pizzint.watch API"""
    api_url = "https://www.pizzint.watch/api/dashboard-data"
    api_response = http.get(api_url)
    
    if api_response == None or api_response.status_code != 200:
        return None, "API Error", "MONITORING PIZZA FREQUENCIES"
    
    api_body = api_response.body()
    if api_body == None or api_body == "":
        return None, "Empty API response", "MONITORING PIZZA FREQUENCIES"
    
    api_str = str(api_body)
    api_lower = api_str.lower()
    
    for level in [1, 2, 3, 4, 5]:
        patterns = [
            "\"defcon_level\":" + str(level),
            "\"defcon_level\": " + str(level),
            "\"defconLevel\":" + str(level),
            "\"defconLevel\": " + str(level),
            "\"defcon\":" + str(level),
            "\"defcon\": " + str(level),
        ]
        for pattern in patterns:
            if api_lower.find(pattern) >= 0:
                if level >= 1 and level <= 5:
                    status_text = get_status_text_for_level(level)
                    return level, None, status_text
    
    return None, "DEFCON level not found in API", "MONITORING PIZZA FREQUENCIES"

def create_pizza_sprite():
    """Create a triangular pizza slice with crust, sauce, and pepperoni"""
    crust_color = PIZZA_CRUST_COLOR
    sauce_color = PIZZA_SAUCE_COLOR
    pepperoni_color = PIZZA_PEPPERONI_COLOR
    
    top_crust = render.Box(width=16, height=2, color=crust_color)
    row2 = render.Row(
        children=[
            render.Box(width=2, height=2, color=crust_color),
            render.Box(width=12, height=2, color=sauce_color),
            render.Box(width=2, height=2, color=crust_color),
        ],
        main_align="start",
    )
    
    row3 = render.Row(
        children=[
            render.Box(width=2, height=2, color=crust_color),
            render.Box(width=3, height=2, color=sauce_color),
            render.Box(width=3, height=2, color=pepperoni_color),
            render.Box(width=3, height=2, color=sauce_color),
            render.Box(width=2, height=2, color=crust_color),
        ],
        main_align="start",
    )
    
    row4 = render.Row(
        children=[
            render.Box(width=2, height=2, color=crust_color),
            render.Box(width=3, height=2, color=pepperoni_color),
            render.Box(width=4, height=2, color=sauce_color),
            render.Box(width=2, height=2, color=crust_color),
        ],
        main_align="start",
    )
    
    row5 = render.Row(
        children=[
            render.Box(width=2, height=2, color=crust_color),
            render.Box(width=8, height=2, color=sauce_color),
            render.Box(width=2, height=2, color=crust_color),
        ],
        main_align="start",
    )
    
    row6 = render.Row(
        children=[
            render.Box(width=2, height=2, color=crust_color),
            render.Box(width=2, height=2, color=sauce_color),
            render.Box(width=2, height=2, color=pepperoni_color),
            render.Box(width=2, height=2, color=sauce_color),
            render.Box(width=2, height=2, color=crust_color),
        ],
        main_align="start",
    )
    
    row7 = render.Row(
        children=[
            render.Box(width=2, height=2, color=crust_color),
            render.Box(width=4, height=2, color=sauce_color),
            render.Box(width=2, height=2, color=crust_color),
        ],
        main_align="start",
    )
    
    row8 = render.Row(
        children=[
            render.Box(width=2, height=2, color=crust_color),
            render.Box(width=2, height=2, color=sauce_color),
            render.Box(width=2, height=2, color=crust_color),
        ],
        main_align="start",
    )
    
    row9 = render.Row(
        children=[
            render.Box(width=1, height=2, color=crust_color),
            render.Box(width=2, height=2, color=sauce_color),
            render.Box(width=1, height=2, color=crust_color),
        ],
        main_align="start",
    )
    
    row10 = render.Row(
        children=[
            render.Box(width=1, height=2, color=crust_color),
            render.Box(width=1, height=2, color=sauce_color),
        ],
        main_align="start",
    )
    
    bottom_point_row = render.Box(width=1, height=2, color=crust_color)
    return render.Column(
        children=[
            top_crust,
            row2,
            row3,
            row4,
            row5,
            row6,
            row7,
            row8,
            row9,
            row10,
            bottom_point_row,
        ],
        main_align="start",
        cross_align="center",
    )

def main(config):
    level, error, status_lines = fetch_defcon_data()
    
    if level == None:
        level = 3
        status_lines = "MONITORING PIZZA FREQ"
        if error:
            status_lines = "ERROR FETCH DATA"
    
    if level == None or level < 1 or level > 5:
        level = 3
    
    color = get_defcon_color(level)
    container_outer = render.Box(
        width=DISPLAY_WIDTH,
        height=DISPLAY_HEIGHT,
        color=color,
    )
    
    container_inner = render.Box(
        width=DISPLAY_WIDTH - 2,
        height=DISPLAY_HEIGHT - 2,
        color=BG_COLOR,
    )
    
    container = render.Stack(
        children=[
            container_outer,
            render.Padding(pad=1, child=container_inner),
        ],
    )
    
    level_str = str(level)
    if len(level_str) > 1:
        level_str = level_str[0]
    
    defcon_text = render.Stack(
        children=[
            render.Text(content=level_str, color=color, font="6x13"),
            render.Text(content=level_str, color=color, font="6x13"),
            render.Text(content=level_str, color=color, font="6x13"),
            render.Text(content=level_str, color=color, font="6x13"),
            render.Text(content=level_str, color=color, font="6x13"),
            render.Text(content=level_str, color=color, font="6x13"),
            render.Text(content=level_str, color=color, font="6x13"),
            render.Text(content=level_str, color=color, font="6x13"),
            render.Text(content=level_str, color=color, font="6x13"),
            render.Text(content=level_str, color=color, font="6x13"),
        ],
    )
    
    full_status_text = ""
    if status_lines != None and status_lines != "":
        full_status_text = str(status_lines)
    else:
        full_status_text = "MONITORING PIZZA FREQUENCIES"
    
    scrolling_text = SCROLL_PADDING + full_status_text + SCROLL_PADDING
    
    time_val = 0
    if config != None:
        if hasattr(config, "now"):
            time_val = config.now
        elif hasattr(config, "v") and config.v != None:
            if hasattr(config.v, "get"):
                time_val = config.v.get("now", 0)
            elif hasattr(config.v, "now"):
                time_val = config.v.now
    
    total_pixels = len(scrolling_text) * CHAR_WIDTH
    
    offset_start = 0
    offset_end = -total_pixels
    if time_val > 0:
        offset_start = int(time_val * SCROLL_SPEED) % total_pixels
        offset_end = offset_start - total_pixels
    
    status_text_display = render.Marquee(
        width=DISPLAY_WIDTH,
        height=TEXT_HEIGHT,
        child=render.Text(
            content=scrolling_text,
            color=color,
        ),
        scroll_direction="horizontal",
        offset_start=offset_start,
        offset_end=offset_end,
        align="start",
    )
    
    top_section = render.Row(
        children=[
            render.Box(
                width=PIZZA_WIDTH,
                height=TOP_SECTION_HEIGHT,
                child=render.Column(
                    children=[create_pizza_sprite()],
                    main_align="center",
                    cross_align="center",
                ),
            ),
            render.Box(
                width=DEFCON_WIDTH,
                height=TOP_SECTION_HEIGHT,
                child=render.Column(
                    children=[
                        render.Row(
                            children=[
                                render.Text(
                                    content="DEFCON",
                                    color=color,
                                ),
                            ],
                            main_align="center",
                            cross_align="center",
                        ),
                        render.Row(
                            children=[defcon_text],
                            main_align="center",
                            cross_align="center",
                        ),
                    ],
                    main_align="center",
                    cross_align="center",
                ),
            ),
        ],
        main_align="start",
        cross_align="start",
    )
    
    all_content = render.Column(
        children=[
            render.Box(
                width=DISPLAY_WIDTH,
                height=CONTENT_HEIGHT,
                child=top_section,
            ),
            render.Box(width=DISPLAY_WIDTH, height=SPACER_HEIGHT, color=SPACER_COLOR),
            status_text_display,
        ],
        main_align="start",
        cross_align="start",
    )
    
    padded_content = render.Padding(
        pad=1,
        child=all_content,
    )
    
    final_display = render.Stack(
        children=[
            container,
            padded_content,
        ],
    )
    
    return render.Root(
        child=final_display,
    )
