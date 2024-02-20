class MoviesController < ApplicationController
  def new
    @movie = Movie.new

    #render template: "movies/new"
  end

  def index
    matching_movies = Movie.all

    @movies = matching_movies.order({ :created_at => :desc })

    respond_to do |format|
      format.json do
        render json: @movies
      end

      format.html do
        render template: "movies/index" 
      end
    end
  end

  def show
    # #get id
    # the_id = params.fetch(:id)

    # #search
    # matching_movies = Movie.where({ :id => the_id })

    # #get first one
    # @the_movie = matching_movies.first

    # @the_movie = Movie.where( id: params.fetch(:id)).first

    # @the_movie = Movie.find_by( id: params.fetch( :id ))

    @movie = Movie.find( params.fetch( :id ))


    #render template: "movies/show" 
  end

  def create
    # @movie = Movie.new
    # @movie.title = params.fetch(:movie).fetch(:title) #in params we usually use symbols instead of strings 
    # @movie.description = params.fetch(:movie).fetch(:description)

    movie_attributes = params.require(:movie).permit(:title,:description) #returns object of another class
    @movie = Movie.new(movie_attributes)

    if @movie.valid?
      @movie.save
      redirect_to("/movies", { :notice => "Movie created successfully." })
    else
      render template: "movies/new"
    end
  end

  def edit
    # the_id = params.fetch(:id)

    # matching_movies = Movie.where({ :id => the_id })

    # @the_movie = matching_movies.first
    
    @movie = Movie.find(params.fetch(:id))

    #render template: "movies/edit"
  end

  def update
    
    movie_attributes = params.require(:movie).permit(:title,:description)

    @movie = Movie.find(params.fetch(:id))

    @movie.update(movie_attributes)

    

    if @movie.valid?
      @movie.save
      redirect_to movie_url(@movie), notice: "Movie updated successfully."
    else
      redirect_to movie_url(@movie), alert: "Movie failed to update successfully"
    end
  end

  def destroy
    the_id = params.fetch(:id)
    the_movie = Movie.where({ :id => the_id }).first

    the_movie.destroy

    redirect_to movies_url, notice: "Movie deleted successfully."
  end
end
