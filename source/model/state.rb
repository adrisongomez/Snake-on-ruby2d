module Model
  module Direction
    UP = :up
    RIGHT = :right
    LEFT = :left
    DOWN = :down
  end
  class Coordinate < Struct.new(:px, :py)
  end

  class Food < Coordinate
  end

  class Snake < Struct.new(:positions)
  end

  class Playground < Struct.new(:cols, :rows)
  end

  class State < Struct.new(:snake, :food, :playground, :curr_direction, :game_finished)
  end

  def self.initial_state
    Model::State.new(
      Model::Snake.new([
        Model::Coordinate.new(1,1),
        Model::Coordinate.new(0,1),
      ]),
      Model::Food.new(4,4),
      Model::Playground.new(20, 20),
      Model::Direction::DOWN,
      false
    )
  end

end
