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

    @the_movie = Movie.find( params.fetch( :id ))


    #render template: "movies/show" 
  end

  def create
    @movie = Movie.new
    @movie.title = params.fetch(:movie).fetch(:title) #in params we usually use symbols instead of strings 
    @movie.description = params.fetch(:movie).fetch(:description)

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

    @the_movie = Movie.find(params.fetch( :id ))

    #render template: "movies/edit"
  end

  def update
    the_id = params.fetch(:id)
    the_movie = Movie.where({ :id => the_id }).first

    the_movie.title = params.fetch("query_title")
    the_movie.description = params.fetch("query_description")

    if the_movie.valid?
      the_movie.save
      redirect_to movie_url(the_movie), notice: "Movie updated successfully."
    else
      redirect_to "/movies/#{the_movie.id}", alert: "Movie failed to update successfully."
    end
  end

  def destroy
    the_id = params.fetch(:id)
    the_movie = Movie.where({ :id => the_id }).first

    the_movie.destroy

    redirect_to movies_url, notice: "Movie deleted successfully."
  end
end
