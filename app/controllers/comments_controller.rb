class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_articulo
  before_action :set_comment, only: [:update, :destroy]

  # GET /comments
  # GET /comments.json
=begin
estos metodos ya no se necesitan ya que no son necesarios
y estan bloqueados desde el routes. No son necesarios para esta aplicación.
  def index
    @comments = Comment.all
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
  end

  # GET /comments/new
  def new
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit
  end
=end

  # POST /comments
  # POST /comments.json
  def create
    #se cambia
    #@comment = Comment.new(comment_params)
    #por:
    @comment = current_user.comments.new(comment_params)
    #porque de esa manera es que se asocia el comentario al usuario

    #aca le decimos que el articulo es el de la url
    #ya que se esta seteando gracias al callback set_articulo
    #
    @comment.article = @articulo
    

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @comment.article, notice: 'Comment was successfully created.' }
        format.json { render :show, status: :created, location: @comment }
      else
        #format.html { render :new }
        format.html { redirect_to @comment.article, alert: 'No se pudo crear el comentario.' }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @comment.article, notice: 'Comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to @articulo, notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:user_id, :article_id, :body)
    end

    def set_articulo
      #esta funcion hace refactor de el trozo de codigo:
      @articulo = Article.find(params[:article_id])
      #el parametro es article_id porque debe referencial al padre
      #del que se está hablando.
      #lo cual me permite no repetirlo cada vez que inicia
      #una funcion que necesita inicializar el array con los
      #datos del artículo.
    end

end
