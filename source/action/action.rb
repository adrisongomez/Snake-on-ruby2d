require_relative '../model/state' 

module Action

  def self.move_snake(state)
    curr_direction = state.curr_direction
    next_position = clac_next_position(state)
    if position_is_food? state, next_position
      state = grow_snake(state, next_position)
      return generate_food(state)
    elsif position_is_valid? state, next_position
      return move_snake_to(state, next_position)
    else
      return end_game(state)
    end

  end

  def self.change_direction(state, direction)
    if next_direction_is_invalid? state, direction
      return state
    else
      return change_direction_to(state, direction)
    end
  end

  def self.grow_snake(state, postion)
    state.snake.positions = [postion] + state.snake.positions
    state
  end

  private

  def self.generate_food(state)
    food = Model::Food.new(
      rand(state.playground.cols),
      rand(state.playground.rows)
    )
    state.food = food
    state
  end

  def self.position_is_food?(state, position)
    food = state.food
    food.px == position.px && food.py == position.py
  end

  def self.change_direction_to(state, direction)
    state.curr_direction = direction
    state
  end

  def self.clac_next_position(state)
    old_position = state.snake.positions.first
    case state.curr_direction
      when Model::Direction::UP
        return Model::Coordinate.new(old_position.px, old_position.py - 1)
      when Model::Direction::RIGHT
        return Model::Coordinate.new(old_position.px + 1, old_position.py)
      when Model::Direction::DOWN
        return Model::Coordinate.new(old_position.px, old_position.py + 1)
      when Model::Direction::LEFT
        return Model::Coordinate.new(old_position.px - 1, old_position.py)
    end
  end
  

  def self.position_is_valid?(state, position)
    is_out_of_playground = ((position.px > state.playground.rows || position.py > state.playground.cols) ||
        (position.px < 0 || position.py < 0))
    return false if is_out_of_playground

    is_over_snake = state.snake.positions.include? position
  
    return !is_over_snake

  end

  def self.move_snake_to(state, position)
    new_positions = [position] + state.snake.positions[0...-1] 
    state.snake.positions = new_positions
    state
  end

  
  def self.end_game(state)
    state.game_finished = true
    state
  end

  def self.next_direction_is_invalid?(state, direction)
    case state.curr_direction
      when Model::Direction::UP
        return true if direction == Model::Direction::DOWN
      when Model::Direction::RIGHT
        return true if direction == Model::Direction::LEFT
      when Model::Direction::DOWN
        return true if direction == Model::Direction::UP
      when Model::Direction::LEFT
        return true if direction == Model::Direction::RIGHT
    end
    return false
  end

end
