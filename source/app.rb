require_relative 'view/view'
require_relative 'model/state'
require_relative 'action/action'

class App

  def initialize
    @state = Model::initial_state
    @view = View::Ruby2dView.new(self)
  end

  def start
    thread = Thread.new { init_timer } 
    @view.start(@state)
    thread.join
  end

  def init_timer
    loop do
      if @state.game_finished
        puts "Game finished"
        break
      end
      @state = Action::move_snake(@state)
      @view.dibuja_juego(@state)
      sleep 0.5
    end
  end

  def send_action(action, payload)
    new_state = Action.send(action, @state, payload)
    if new_state.hash != @state.hash
      @state = new_state
      view.render(@state)
    end
  end
end

app = App.new
app.start

