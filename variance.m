% Set initial population size and genome length
pop_size = 100; %Suppose the population size is 100.
genome_length = 50;%Suppose the genome length is 50.

% Randomly generated initial populations
pop = rand(pop_size, genome_length);%Define randomly the initial gene pool of gorillas: pop.(0,1)

% Design of fitness functions to evaluate the fitness of each gorilla
fitness = zeros(pop_size, 1);
for i=1:pop_size
    % In the fitness function, gorillas can be considered for assessment based on their behavior, survivability, and other aspects
    fitness(i) = var(pop(i,:)); % The variance of the corresponding array of genomes was used as the fitness of the gorilla.
end

% Undergoes multi-generational evolution with selection, crossover and mutation per generation
num_generations = 50; %Suppose the number of generation is 50.
max_fitness=zeros(50,1); %Set max_fitness for recording max fitness of each generation.
for gen=1:num_generations
    % Selecting highly adaptable gorillas
    [~, idx] = sort(fitness, 'descend'); %Descending order of fitness.
    elite = pop(idx(1:10), :); %The gorillas with the top 10% of fitness were selected as elite.

    % Undergo crossover and mutation to produce new gorilla individuals
    new_pop = zeros(pop_size, genome_length);
    for i=1:pop_size
        % Randomly select two gorillas for crossover
        parent1 = elite(randi(size(elite,1)), :);
        parent2 = elite(randi(size(elite,1)), :);
        crossover_point = randi(genome_length - 1);
        new_pop(i,:) = [parent1(1:crossover_point) parent2(crossover_point+1:end)];
        
        % Mutation with a certain probability
        mutation_rate = 0.01;
        if rand() < mutation_rate
            mutation_point = randi(genome_length);
            new_pop(i, mutation_point) = rand();
        end
    end
    
    % Updating populations
    pop = new_pop;
    
    % Update fitness
    for i=1:pop_size
        fitness(i) = var(pop(i,:));
    end
    
    % Output the highest fitness per generation
    max_fitness(gen)=max(fitness);
    fprintf('Generation %d: Best fitness = %f\n', gen, max_fitness);
 
  
   
end
plot(max_fitness) 
xlabel({'Generations'});
ylabel({'Max(fitness) of each generation'});

