class StudentsController < ApplicationController
    def index
        @students = Student.all
    end

    def show
        @student = Student.find(params[:id])
    end

    def new
        @student = Student.new
    end

    def create
        @student = Student.new(student_params)

        if @student.save
            redirect_to @student
        else
            render :new
        end
    end

    def edit
        @student = Student.find(params[:id])
    end

    def update
      @student = Student.find(params[:id])
  
      if @student.update(student_params)
        redirect_to @student
      else
        render :edit
      end
    end
    
    def destroy
      @student = Student.find(params[:id])
      @student.destroy
  
      redirect_to root_path
    end

    def get_year_with_most_men_percentage
      @years = Student.distinct.pluck(:year)
      
      @percentage = 0
      @years_with_percentage = []

      @years.each do |year|
        puts year
        students_total = Student.group(:year).count[year]
        men = Student.select { |student| student.year == year && student.sex }.count
        value = 100.0*men/students_total
        puts value
        if value > @percentage
          @percentage = value
          @years_with_percentage = [year]
        elsif value == @percentage
          @years_with_percentage.push(year)
        end
      end
    end


    def get_women_students_with_most_popular_age
      women = Student.select {|student| !student.sex}

      count = Hash.new(0)

      women.each do |w|
        count[w.age] += 1
      end

      max_count = count.values.max
      ages = count.select {|age, count| age if count == max_count}


      @students = Student.select { |student| !student.sex && (ages.include? student.age) }.map { |s| get_name_initials(s) }.sort
    end

    def get_most_popular_names_men
      @students = get_most_popular_names(true)
    end

    def get_most_popular_names_women
      @students = get_most_popular_names(false)
    end

    private
    def get_most_popular_names(sex)
      students = Student.select {|student| student.sex == sex}
      count = Hash.new(0)
      students.each do |s|
        count[s.first_name] += 1
      end
      puts count
      return count.select { |name, v| name if v == count.values.max }
    end

    
    private
    def get_name_initials(student)
      "#{student.last_name} #{student.first_name[0]}. #{student.middle_name[0]}."
    end

  private
    def student_params
      params.require(:student).permit(:first_name, :last_name, :middle_name, :sex, :age, :year)
    end
end
