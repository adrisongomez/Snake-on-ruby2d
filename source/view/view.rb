require "ruby2d"

module View
  class Ruby2dView

    def initialize(app)
      @pixel_size = 20
      @app = app
    end

    def dibuja_juego(state)
      extend Ruby2D::DSL
      close if state.game_finished
      render_food(state)
      render_snake(state)
    end

    def start(state)
      extend Ruby2D::DSL
      set(
        title: "Snake",
        width: @pixel_size * state.playground.cols,
        height: @pixel_size * state.playground.rows)
      
      on :key_down do |event|
        handle_key_event(event)
      end

      show

    end


    private

    def render_food(state)
      @food.remove if @food
      extend Ruby2D::DSL
      food = state.food
      @food = Square.new(
        x: food.px * @pixel_size,
        y: food.py * @pixel_size,
        size: @pixel_size,
        color: 'blue'
      )
    end

    def render_snake(state)
      @snake.each(&:remove) if @snake
      extend Ruby2D::DSL
      snake = state.snake
      @snake = snake.positions.map do |pos|
        Square.new(
          x: pos.px * @pixel_size,
          y: pos.py * @pixel_size,
          size: @pixel_size,
          color: 'green'
        )
      end
    end


    def handle_key_event(event)
      case event.key
      when 'j'
        @app.send_action(:change_direction, Model::Direction::DOWN)
      when 'l'
        @app.send_action(:change_direction, Model::Direction::RIGHT)
      when 'k'
        @app.send_action(:change_direction, Model::Direction::UP)
      when 'h'
        @app.send_action(:change_direction, Model::Direction::LEFT)
      end
    end

  end

end
