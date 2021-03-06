class TopicsController < ApplicationController
before_action :set_topic_id, only: [:show_topic, :edit, :destroy]
before_action :set_post_id, only: [:edit_post]


def index
    @project = Project.find(params[:id])
    @topics = @project.topics.order(important: :desc)
end

def make_important
    topic = Topic.find(params[:topic])
    topic.important = true
    project = Project.find(topic.project_id)
    topic.save
    flash[:success] = 'Tópico fixado como importante.'
    redirect_to list_topics_path(project)
end

def make_not_important
    topic = Topic.find(params[:topic])
    topic.important = false
    project = Project.find(topic.project_id)
    topic.save
    redirect_to list_topics_path(project)
end

def new
	@topic = Topic.new
	@project = params[:id]
end

def show_topic
  @project = @topic.project
end

def create
    @topic = Topic.new(topic_params)
    @topic.user_id = current_user.id
    @project = Project.find(@topic.project_id)
    respond_to do |format|

      if @topic.save
        @project.members.where(situation: 1).each do |member|
          if member.user_id != current_user.id
            @topic.create_activity(:create, :owner => User.find(member.user_id))
          end
        end
        format.html { redirect_to list_topics_path(@project), notice: 'Tópico criado com sucesso.' }
        format.json { render :show, status: :created, location: @project}
      else
        format.html { render :new }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

def edit
end

def update
  @topic = Topic.find(params[:id])
  @topic.update(topic_params)
  flash[:success] = 'Tópico atualizado com sucesso.'
  redirect_to controller: 'topics', action: 'index', id: @topic.project.id
end

def destroy
  project = @topic.project
  @topic.destroy
  flash[:success] = 'Tópico excluído com sucesso.'
  redirect_to controller: 'topics', action: 'index', id: project.id 
end




def new_post
  @post = Post.new
  @topic = params[:id_topic]
end

def create_post
  @post = Post.new(post_params)
  @post.user_id = current_user.id
  topic = Topic.find(@post.topic_id)
  respond_to do |format|
    if @post.save
      format.html { redirect_to controller: 'topics', action: 'show_topic', id: @post.topic.project.id, id_topic: @post.topic.id, notice: 'Post was successfully created.' }
      format.json { render :show, status: :created, location: topic}
    else
      format.html { render :new }
      format.json { render json: @topic.errors, status: :unprocessable_entity }
    end
  end
end

def edit_post
  @post_id = params[:id_post]
end

def update_post
  @post = Post.find(params[:id_post])
  @post.update(post_params)
  redirect_to controller: 'topics', action: 'show_topic', id: @post.topic.project.id, id_topic: @post.topic.id, notice: 'Post was successfully updated.'
end

def destroy_post
  @post = Post.find(params[:id])
  topic = @post.topic
  @post.destroy
  redirect_to controller: 'topics', action: 'show_topic', id_topic: topic.id, id: topic.project.id, notice: 'Post was successfully destroyed.' 
end


  private
    # Use callbacks to share common setup or constraints between actions.
    def load_activities
      @activities = PublicActivity::Activity.order('created_at DESC').limit(20)
    end

    def set_topic
      @topic = Topic.find(params[:id])
    end

     def set_topic_id
      @topic = Topic.find(params[:id_topic])
    end

    def set_post_id
      @post = Post.find(params[:id_post])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def topic_params
      params.require(:topic).permit(:topic_title, :description, :important, :user_id, :project_id)
    end

    def post_params
      params.require(:post).permit(:description, :user_id, :topic_id)
    end
end
