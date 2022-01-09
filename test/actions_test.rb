require "minitest/autorun"
require "minitest/mock"
require_relative "../source/model/state"
require_relative "../source/action/action"

class ActionsTest < Minitest::Test
  
  def setup
    @initial_state = Model::State.new(
      Model::Snake.new([
          Model::Coordinate.new(1,1),
          Model::Coordinate.new(0,1)
      ]),
      Model::Food.new(4, 4),
      Model::Playground.new(8, 12),
      Model::Direction::DOWN,
      false
    )
  end

  def test_move_snake
    expected_state = Model::State.new(
      Model::Snake.new([
          Model::Coordinate.new(1,2),
          Model::Coordinate.new(1,1)
      ]),
      Model::Food.new(4, 4),
      Model::Playground.new(8, 12),
      Model::Direction::DOWN,
      false
    )
    
    actual_state = Action::move_snake(@initial_state)
    assert_equal actual_state, expected_state
  end

  def test_change_direction_invalid
    expected_state = Model::State.new(
      Model::Snake.new([
          Model::Coordinate.new(1,1),
          Model::Coordinate.new(0,1)
      ]),
      Model::Food.new(4, 4),
      Model::Playground.new(8, 12),
      Model::Direction::DOWN,
      false
    )

    actual_state = Action::change_direction(@initial_state, Model::Direction::UP)
    assert_equal actual_state, expected_state
  end

  def test_change_direction_valid
    expected_state = Model::State.new(
      Model::Snake.new([
          Model::Coordinate.new(1,1),
          Model::Coordinate.new(0,1)
      ]),
      Model::Food.new(4, 4),
      Model::Playground.new(8, 12),
      Model::Direction::LEFT,
      false
    )

    actual_state = Action::change_direction(@initial_state, Model::Direction::LEFT)
    assert_equal actual_state, expected_state
  end

  def test_snake_grow
    initial_state = Model::State.new(
      Model::Snake.new([
          Model::Coordinate.new(1,1),
          Model::Coordinate.new(0,1)
      ]),
      Model::Food.new(1,2),
      Model::Playground.new(8, 12),
      Model::Direction::DOWN,
      false
    )
    
    actual_state = Action::move_snake(initial_state)
    assert_equal(actual_state.snake.positions, [
          Model::Coordinate.new(1,2),
          Model::Coordinate.new(1,1),
          Model::Coordinate.new(0,1)
      ])
  end

  def test_generate_food
    initial_state = Model::State.new(
      Model::Snake.new([
          Model::Coordinate.new(1,1),
          Model::Coordinate.new(0,1)
      ]),
      Model::Food.new(1,2),
      Model::Playground.new(8, 12),
      Model::Direction::DOWN,
      false
    )
    expected_state = Model::State.new(
      Model::Snake.new([
          Model::Coordinate.new(1,2),
          Model::Coordinate.new(1,1),
          Model::Coordinate.new(0,1),
      ]),
      Model::Food.new(0,0),
      Model::Playground.new(8, 12),
      Model::Direction::DOWN,
      false
    )
    
    Action.stub(:rand, 0) do
      actual_state = Action::move_snake(initial_state)
      assert_equal actual_state, expected_state
    end
  end
end