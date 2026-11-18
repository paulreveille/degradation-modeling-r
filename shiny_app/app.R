# Appel à la librairie shiny

library(shiny)
library(bslib)
library(shinyWidgets)

## Interface utilisateur qui contrôle la disposition et 
## l'apparence de l'application.

ui <- page_navbar(
  
  ## Titre de l'application 
  
  title = "Étude des modèles de dégradation",
  
  ## Couleur de la bande principale.
  
  bg = "lightgrey",
  
  ##
  ## Fenêtre du Processus de Wiener.
  ##
  nav_panel(title = "Processus de Wiener",p(page_sidebar(sidebar = sidebar(bg = "lightgrey",
                                                                           ## Pour pouvoir écrire en latex
                                                                           withMathJax(),
                                                                           ## Titre du modèle
                                                                           h5("Modèle étudié :"),
                                                                           ## Expression latex
                                                                           helpText("$$ X(t) = \\mu.t + \\sigma.B_t $$"),
                                                                           ## Ligne de séparation
                                                                           hr(),
                                                              selectInput(inputId = "Choix_loi3", ## Titre non visible référence pour nous.
                                                                          label = "Choix de la distribution des dates",
                                                                          choices =c("Constant","Aléatoire","Uniforme","Exponentielle"),
                                                                          selected = "Constant"),
                                                              numericInput(inputId = "Choix_pts3",
                                                                           label = "Nombre points",
                                                                           value = 30, ## Nombre de points initial
                                                                           min = 30,
                                                                           max = 1000
                                                                           ),
                                                              numericInput(inputId = "Choix_mu3",
                                                                           label = "Tendance (drift) \\(\\mu \\)",
                                                                           value = 0,
                                                                           min = 0,
                                                                           max = 100,
                                                                           ),
                                                              numericInput(inputId = "Choix_sig3",
                                                                           label = "Volatilité \\( \\sigma \\)",
                                                                           value = 0,
                                                                           min = 0,
                                                                           max = 100,
                                                                           ),
                                                              numericInput(inputId = "Choix_nbt3",
                                                                           label = "Nombre de tracés",
                                                                           value = 1,
                                                                           min = 1,
                                                                           max = 100,
                                                                           ),
                                                              numericInput(inputId = "Choix_seuil3",
                                                                           label = "Seuil",
                                                                           value = 0,
                                                                           min = 0,
                                                                           max = 100,
                                                                           ),
                                                              selectInput(inputId = "Choix_stat3",
                                                                          label = "Affichage Moyenne",
                                                                          choices = c("Oui","Non"),
                                                                          selected = "Oui",
                                                                          width = "200px",),
                                                              ),
                                                              navset_card_underline(title = "Modélisation du Processus de Wiener",
                                                                              div(style = "position: absolute; bottom: 0; left: 0;",
                                                                                  class = "d-flex gap-2 ms-3 mb-3 align-items-center",
                                                                              ),
                                                                              div(style = "position: absolute; bottom: 0; right: 0;",
                                                                                  class = "d-flex me-3 mb-3",
                                                                                  actionButton(inputId = "Run3",label = "Exécuter",icon = icon("play"),width = "150px",style = "background-color: green; color: white;")),
                                                                              nav_panel(title = "Méthode différentielle",
                                                                                        div(style = "display: flex; justify-content: center; align-items: center; height: 100%; padding-bottom: 60px;",
                                                                                            plotOutput(outputId = "MODWD",height = "800px",width = "80%")),
                                                                                        absolutePanel(style = "position: absolute;bottom: 0;left: 0",
                                                                                                      class = "d-flex gap-2 ms-3 mb-3 align-items-center",
                                                                                          conditionalPanel(condition = "input.Choix_nbt3 > 1",
                                                                                            actionButton(inputId = "Tps_seuil3",
                                                                                                     label = "Temps seuil",
                                                                                                     width = "150px",
                                                                                                     style = "height:50px;background-color: lightgrey; color: dark;")))
                                                                                        ),
                                                                              nav_panel(title = "Méthode avec mouvement Brownien",
                                                                                        div(style = "display: flex; justify-content: center; align-items: center; height: 100%; padding-bottom: 60px;",
                                                                                            plotOutput(outputId = "MODWB",height = "800px",width = "80%"))
                                                                              )
                                                                          ,)
                                            )
            ),
  ),
  
  ##
  ## Fenêtre du Processus Gamma
  ##
  
  nav_panel(title = "Processus Gamma",p(page_sidebar(sidebar  = sidebar(bg = "lightgrey",
                                                                        withMathJax(),
                                                                        ## Titre du modèle
                                                                        h5("Modèle étudié :"),
                                                                        ## Expression latex
                                                                        helpText("$$\\begin{aligned}& \\forall s < t, \\\\& X(t)-X(s) \\sim \\mathcal{G}(a(t-s),b)\\end{aligned}$$"),
                                                                        ## Ligne de séparation
                                                                        hr(),
                                                                        selectInput(inputId = "Choix_loi4",
                                                                                    label = "Choix de la distribution des dates",
                                                                                    choices = c("Constant","Aléatoire","Uniforme","Exponentielle"),
                                                                                    selected = "Constant"),
                                                                        numericInput(inputId = "Choix_pts4",
                                                                                     label = "Nombres de points",
                                                                                     value = 30,
                                                                                     min = 30,
                                                                                     max = 1000),
                                                                        numericInput(inputId = "Choix_a",
                                                                                     label = "Paramètre de forme a",
                                                                                     value = 0,
                                                                                     min = 0,
                                                                                     max = 100),
                                                                        numericInput(inputId = "Choix_b",
                                                                                     label = "Paramètre de taux b",
                                                                                     value = 0,
                                                                                     min = 0,
                                                                                     max = 100),
                                                                        numericInput(inputId = "Choix_nbt4",
                                                                                     label = "Nombre de trajectoires",
                                                                                     value = 1,
                                                                                     min = 1,
                                                                                     max = 100),
                                                                        numericInput(inputId = "Choix_seuil4",
                                                                                     label = "Seuil",
                                                                                     value = 0,
                                                                                     min = 0,
                                                                                     max = 100),
                                                                        selectInput(inputId = "Choix_stat4",
                                                                                    label = "Affichage Moyenne",
                                                                                    choices = c("Oui","Non"),
                                                                                    selected = "Oui",
                                                                                    width = "200px",),
                                                                        ),
                                                     navset_card_underline(title = "",
                                                                           div(style = "position: absolute;bottom: 0;left: 0",
                                                                           class = "d-flex gap-2 ms-3 mb-3 align-items-center",
                                                                           ),
                                                                           div(style = "position: absolute; bottom: 0; right: 0;",
                                                                               class = "d-flex me-3 mb-3",
                                                                               actionButton(inputId = "Run4",label = "Exécuter",icon = icon("play"),width = "150px",style = "background-color: green; color: white;")),
                                                                           nav_panel(title = "Modélisation du Processus Gamma",
                                                                                     absolutePanel(style = "position: absolute;bottom: 0;left: 0",
                                                                                                   class = "d-flex gap-2 ms-3 mb-3 align-items-center",
                                                                                                   conditionalPanel(condition = "input.Choix_nbt4 > 1",
                                                                                                                    actionButton(inputId = "Tps_seuil4",
                                                                                                                                 label = "Temps seuil",
                                                                                                                                 width = "150px",
                                                                                                                                 style = "height:50px;background-color: lightgrey; color: dark;"))),
                                                                                     div(style = "display: flex; justify-content: center; align-items: center; height: 100%; padding-bottom: 60px;",
                                                                                         plotOutput(outputId = "MODG",height = "800px",width = "80%"))
                                                                           ),
                                                                           )
                                                     
                                                     )
                                        ),
  ),
  ##
  ## Fenêtre des résultats pour les données du laser
  ##
  nav_panel(title = "Laser Data",
            p(page_sidebar(sidebar = sidebar(bg = "lightgrey",
                                             numericInput(inputId = "Choix_nbt2",
                                                          label = "Nombre de tracés",
                                                          value = 1,
                                                          min = 1,
                                                          max = 9
                                             ),
                                             numericInput(inputId = "Choix_seuil2",
                                                          label = "Seuil",
                                                          value = 0,
                                                          min = 0,
                                                          max = 15.0,
                                             ),
                                             selectInput(inputId = "Elog2",
                                                          label = "Échelle log",
                                                          choices = c("Oui","Non"),
                                                          ),
                                             
              ),
              navset_card_underline(
                title = "",
                div(style = "position: absolute; bottom: 0;right: 0;",
                    class = "d-flex me-3 mb-3",
                    actionButton(input = "Run2",label = "Exécuter",icon = icon("play"),width = "150px",style = "background-color: green;color: white;"),
                    ),
                div(style = "position: absolute; bottom: 0;left: 0;",
                    class = "d-flex gap-2 ms-3 mb-3 align-items-center", 
                    actionButton(inputId = "EstL",
                             label = "Estimation",
                             width = "150px",
                             style = "height:50px;background-color: lightgrey; color: dark;"),
                    conditionalPanel(condition = "input.Elog2 == 'Non'",
                      actionButton(inputId = "Tps_seuil2",
                                 label = "Temps seuil",
                                 width = "150px",
                                 style = "height:50px;background-color: lightgrey; color: dark;"))),
                nav_panel(
                  title = "Dégradation du laser en fonction du temps",
                  div(style = "display: flex; justify-content: center; align-items: center; height: 100%; padding-bottom: 60px;",
                      plotOutput(outputId = "SimL",height = "800px",width = "80%"))
                )
            )
            ),
  )
  ),
  ##
  ## Fenêtre des résultats pour les données du semi-conducteur
  ##
  nav_panel(title = "Semi-conductor Data",
            p(page_sidebar(sidebar = sidebar(bg = "lightgrey",
                                             numericInput(inputId = "Choix_nbt",
                                                          label = "Nombre de tracés",
                                                          value = 1,
                                                          min = 1,
                                                          max = 5,
                                             ),
                                             numericInput(inputId = "Choix_seuil",
                                                          label = "Seuil",
                                                          value = 0,
                                                          min = 0,
                                                          max = 3.0,
                                             ),
                                             selectInput(inputId = "Elog",
                                                        label = "Échelle log",
                                                        choices = c("Oui","Non"),
                                             )
            ),
            navset_card_underline(
              title = "",
              div(style = "position: absolute; bottom: 0; right: 0;",
                  class = "d-flex me-3 mb-3",
                  actionButton(inputId = "Run",label = "Exécuter",icon = icon("play"),width = "150px",style = "background-color: green; color: white;")),
              div(style = "position: absolute; bottom: 0;left: 0;",
                  class = "d-flex gap-2 ms-3 mb-3 align-items-center", 
                  actionButton(inputId = "EstSC",
                               label = "Estimation",
                               width = "150px",
                               style = "height:50px;background-color: lightgrey; color: dark;"),
                  conditionalPanel(condition = "input.Elog == 'Non'",
                                   actionButton(inputId = "Tps_seuil1",
                                                label = "Temps seuil",
                                                width = "150px",
                                                style = "height:50px;background-color: lightgrey; color: dark;"
                                   ))),
                  
              nav_panel(
                title = "Dégradation du semi-conducteur en fonction du temps",
                div(style = "display: flex; justify-content: center; align-items: center; height: 100%; padding-bottom: 60px;",
                    plotOutput(outputId = "SimSC",height = "800px",width = "80%"))
              )
            )
            ),
                                                                           
    
  )
  ),
  nav_spacer(),
)


# Instructions nécessaire pour créer l'application.

server <- function(input,output){
  
  ##
  ## TRACÉ DU PROCESSUS DE WIENER
  ##
  
  ## Pour les dates 
  
  ## Fonction qui récupère le nombre de dates
  
  choix_pts3 <- eventReactive(input$Run3,{
    return(input$Choix_pts3)
  },ignoreNULL = FALSE)
  
  ## Fonction qui récupère la valeur de la moyenne
  choix_mu3 <- eventReactive(input$Run3,{
    return(input$Choix_mu3)
  },ignoreNULL = FALSE)
  ## Fonction qui récupère la valeur de la variance
  choix_sig3 <- eventReactive(input$Run3,{
    return(input$Choix_sig3)
  },ignoreNULL = FALSE)
  ## Fonction qui récupère le nombre de simulation à faire
  choix_nbS3 <- eventReactive(input$Run3,{
    return(input$Choix_nbt3)
  },ignoreNULL = FALSE)
  ## Fonction qui récupère la valeur du seuil
  choix_seuil3 <- eventReactive(input$Run3,{
    return(input$Choix_seuil3)
  },ignoreNULL = FALSE)
  
  gene_exp <- function(t_min, t_max, nb) {
    ###fonction de génération des dates par loi exponentielle 
    #vérifie qu'elles sont bien dans l'intervalle demandé 
    #paramètres : t_min: borne inf : t_max : borne sup : nb nombre de valeurs 
    lambda <- 2 / (t_max - t_min)
    dates_exp <- c(t_min)
    for (i in 2 : (nb-1)) {
      val = -1
      while (val < t_min || val > t_max) {
        val <- rexp(1, rate = lambda)
      }
      dates_exp[i] <- val 
    }
    dates_exp[nb] <- t_max
    dates_exp<- sort(dates_exp)
    return (dates_exp)
  }
  
  ## Fonction qui configure la sortie pour la méthode avec le mouvement Brownien
  
  output$MODWB <- renderPlot({
    ## Choix de la loi
    loi3 = input$Choix_loi3
    ## Valeur de mu
    mu <- choix_mu3()
    ## Valeur de sigma
    sg <- choix_sig3()
    ## Choix du nombre de tracés 
    nb_tr3 <- choix_nbS3()
    ## Définition de l'intervalle de temps
    t_max3 <- 100
    est_mu3 <- 0
    ## Définition des dates en fonction de la loi choisie
    if (loi3 == "Constant"){
      dates3 <- c(seq(from = 0, to = t_max3, by = (t_max3) / (choix_pts3() -1)))
    }
    if (loi3 == "Aléatoire"){
      dates3 <- c(0, sort(sample(1:(t_max3-1), choix_pts3()-2, replace = FALSE)), t_max3)
    }
    if (loi3 == "Uniforme"){
      dates3 <- c(0, sort(runif(choix_pts3() -2, min = 0, max = t_max3 )), t_max3)
    }
    if (loi3 == "Exponentielle"){
      dates3 <- gene_exp(0, t_max3, choix_pts3())
    }
    ## Définition du mouvement Brownien
    iterations_B <- function(d,x) {
      # Initialiser les valeurs
      B <- numeric(length(d))  # Allouer un vecteur pour les résultats
      memoire <- 0 
      # Première itération
      B[1] = 0
      # Suite des itérations
      for (i in 2:(length(d))) {
        B[i] <- sqrt(d[i]- d[i-1]) * x[i] + memoire  # Algorithme 1.7
        memoire <- B[i]   
      }
      
      return(B)
    }
    
    if (nb_tr3 == 1){
      x_tires = rnorm(choix_pts3())
      ## Définition formule processus Wiener
      W_t <- function(dates) {
        return (mu * dates + sg * iterations_B(dates,x_tires))
      }
      plot(dates3,W_t(dates3), type="l",
           main = "Modélisation du processus de Wiener",
           xlab = "Temps en seconde",
           ylab = "valeur approchée de W_t"
      )
      grid()
      est_mu3 <- mu
      ## Sélection de la statistique à afficher:
      c_stat <- input$Choix_stat3
      if (c_stat == "Oui"){
        abline(0,est_mu3,col = "darkviolet")
      }
    } else{
      generation_trajectoires3 <- function(dates) {
        trajectoires <- matrix(0, nrow = nb_tr3, ncol = choix_pts3())
        
        for (simulation in 1:nb_tr3) {
          # Nouvelle distribution gaussienne pour chaque simulation
          x_tires = rnorm(choix_pts3())
          W_t <- function(dates) {
            return (mu * dates + sg * iterations_B(dates,x_tires))
          }
          trajectoires[simulation, ] <- W_t(dates3)
        }
        
        return(trajectoires)
      }
      grid()
      
      # Générer plusieurs trajectoires
      trajectoires3 <- generation_trajectoires3(dates3)
      
      # Tracer les trajectoires
      
      matplot(dates3, t(trajectoires3), type = "o",pch = 19, las = 1,cex = 0.5,
              lty = 1, lwd = 1.5,
              col= "black",
              main = "Processus de Wiener",
              xlab = "Temps en seconde", ylab = "Valeur approchée de Wt",
              panel.first = grid())
      
      ## Estimation de mu 
      
      valeurs_finales <- trajectoires3[, ncol(trajectoires3)]
      
      # On calcule la moyenne de ces valeurs finales
      X_T_moyen <- mean(valeurs_finales,na.rm = TRUE)
      # L'estimateur est la moyenne finale divisée par le temps total
      est_mu3 <- X_T_moyen / t_max3
      ## Sélection de la statistique à afficher:
      c_stat <- input$Choix_stat3
      if (c_stat == "Oui"){
        abline(0,est_mu3,col = "darkviolet")
      }
    }
    
    
    ## Affichage du seuil
    s3 <- choix_seuil3()
    ## On vérifie si le bouton a déjà été cliqué (ou si une valeur existe)
    if (input$Run3 > 0) {
      abline(h = s3, col = "red", lwd = 2, lty = 2)
    }
    })
  
  ## Fonction qui configure la sortie pour la méthode Différentielle
  
  output$MODWD <- renderPlot({
    set.seed(input$Run)
    ## Choix de la loi
    loi3 = input$Choix_loi3
    ## Valeur de mu
    mu <- choix_mu3()
    ## Valeur de sigma
    sg <- choix_sig3()
    ## Choix du nombre de tracés 
    nb_tr3 <- choix_nbS3()
    ## Définition de l'intervalle de temps 
    t_max3 <- 100
    ## Définition des dates en fonction de la loi choisie
    if (loi3 == "Constant"){
      dates3 <- c(seq(from = 0, to = t_max3, by = (t_max3) / (choix_pts3() -1)))
    }
    if (loi3 == "Aléatoire"){
      dates3 <- c(0, sort(sample(1:(t_max3-1), choix_pts3()-2, replace = FALSE)), t_max3)
    }
    if (loi3 == "Uniforme"){
      dates3 <- c(0, sort(runif(choix_pts3() -2, min = 0, max = t_max3 )), t_max3)
    }
    if (loi3 == "Exponentielle"){
      dates3 <- gene_exp(0, t_max3, choix_pts3())
    }
    # Définition de la fonction du processus de Wiener
    simulation_wiener <- function(dates, mu, sigma, x0) {
      n <- length(dates)
      delta_t <- diff(dates)
      X <- numeric(n)
      X[1] <- x0
      
      for (i in 2:n) {
        incr <- rnorm(1, mean = mu * delta_t[i-1], sd = sigma * sqrt(delta_t[i-1]))
        X[i] <- X[i-1] + incr
      }
      return(X)
    }
    ## Sélection de la statistique à afficher:
    c_stat <- input$Choix_stat3
    ## Tracés
    
    if (nb_tr3 == 1){
      plot(dates3, simulation_wiener(dates3,mu, sg,0), type="l",
         main = "Processus de Wiener",
         xlab = "Temps en secondes",
         ylab = "Valeur approchée de X(t)"
    )
      grid()
      est_mu3 <- mu
      if (c_stat == "Oui"){
          abline(0,est_mu3,col = "darkviolet",lwd = 3)
      }
    } else{
      generation_trajectoires <- function(dates, mu, sigma, x0, n_simulations) {
        # Matrice des trajectoires
        trajectoires <- matrix(0, nrow = n_simulations, ncol = length(dates))
        for (sim in 1:n_simulations) {
          trajectoires[sim, ] <- simulation_wiener(dates, mu, sigma, x0)
        }
        
        # Construction du data.frame
        df <- data.frame(Date = dates, t(trajectoires))
        
        # Noms des colonnes (Simulation_1, Simulation_2, ...)
        colnames(df) <- c("Date", paste0("Simulation_", 1:n_simulations))
        
        # Retourner les deux objets
        return(list(
          trajectoires = trajectoires,
          dataframe = df
        ))
      }
      grid()
      
      # Générer plusieurs trajectoires
      res <- generation_trajectoires(dates3, mu, sg, 0, nb_tr3)
      
      # Tracer les trajectoires
      matplot(dates3, t(res$trajectoires), type = "o",pch = 19, las = 1,cex = 0.5,
              lty = 1, lwd = 1.5,
              #col=rainbow(choix_nbS3()),
              col = "black",
              main = "Processus de Wiener",
              xlab = "Temps en secondes", ylab = "Valeur approchée de X(t)",
              panel.first = grid())
      ## Estimation de mu 
      valeurs_finales <- res$trajectoires[, ncol(res$trajectoires)]
      
      # On calcule la moyenne de ces valeurs finales
      X_T_moyen <- mean(valeurs_finales)
      
      # L'estimateur est la moyenne finale divisée par le temps total
      est_mu3 <- X_T_moyen / t_max3
      if (c_stat == "Oui"){
        abline(0,est_mu3,col = "darkviolet",lwd = 3)
      }
    }

    ## Affichage du seuil
    s3 <- choix_seuil3()
    ## On vérifie si le bouton a déjà été cliqué (ou si une valeur existe)
    if (input$Run3 > 0) {
      abline(h = s3, col = "red", lwd = 2, lty = 2)
    }
    intersection_seuil <- function(df,h){
      nl <- length(df[,1])
      nc <- length(df[1,])
      cat(nl,nc)
      ech <- c()
      for (i in 2:nc){
        j <- 1
        while (j < nl){
          if (df[j,i] < h){
            j <- j + 1
          }else{
            ech <- c(ech,df[j,1])
            break
          }
        }
      }
      return(ech)
    }
    if (!is.null(input$Tps_seuil3) && input$Tps_seuil3 > 0 && input$Tps_seuil3 %% 2 != 0) {
      
      # Sécurité : Si l'utilisateur est en mode "1 seule courbe", 'res' n'existe pas.
      if (exists("res")) { 
        x <- intersection_seuil(res$dataframe, choix_seuil3()) 
        if(length(x) > 0) {
          abline(v = mean(x), col = "red", lwd = 3)
          abline(v = mean(x) - sd(x), col = "darkred", lwd = 3, lty = 2)
          abline(v = mean(x) + sd(x), col = "darkred", lwd = 3, lty = 2)
          legend("topright",
                 legend = c("Dates de défaillance moyenne", "Variance des dates de défaillances"),
                 col = c("red", "darkred"),
                 lty = c(2, 2), lwd = c(3, 3), bg = "white")
        }
      }
    }
  })
  
  ##
  ## TRACÉ POUR LE PROCESSUS GAMMA
  ##
  
  ## Pour les dates 
  
  ## Fonction qui récupère le nombre de dates
  
  choix_pts4 <- eventReactive(input$Run4,{
    return(input$Choix_pts4)
  },ignoreNULL = FALSE)
 
  # Fonction qui récupère la valeur de a
  choix_a <- eventReactive(input$Run4,{
    return(input$Choix_a)
  },ignoreNULL = FALSE)
  # Fonction qui récupère la valeur de la variance
  choix_b <- eventReactive(input$Run4,{
    return(input$Choix_b)
  },ignoreNULL = FALSE)
  # Fonction qui récupère le nombre de simulation à faire
  choix_nbS4 <- eventReactive(input$Run4,{
    return(input$Choix_nbt4)
  },ignoreNULL = FALSE)
  # Fonction qui récupère la valeur du seuil
  choix_seuil4 <- eventReactive(input$Run4,{
    return(input$Choix_seuil4)
  },ignoreNULL = FALSE)
  
  
  
  ## Fonction qui configure la sortie pour la méthode gamma
  
  output$MODG <- renderPlot({
    set.seed(input$Run4)
    ## Choix de la statistique
    c_stat <- input$Choix_stat4
    ## On récupère la loi choisie
    loi4 <- input$Choix_loi4
    ## Définition de l'intervalle de temps
    t_max4 <- 100
    ## Fonction du processus Gamma
    simulation_gamma <- function(dates, alpha, beta, x0) {
      n <- length(dates)
      delta_t <- diff(dates)
      X <- numeric(n)
      X[1] <- x0
      
      for (i in 2:n) {
        incr <- rgamma(1, shape = alpha * delta_t[i-1], rate = beta)
        X[i] <- X[i-1] + incr
      }
      return(X)
    }
    
    ## Définition des dates en fonction de la loi choisie
    if (loi4 == "Constant"){
      dates4 <- c(seq(from = 0, to = t_max4, by = (t_max4) / (choix_pts4() -1)))
    }
    if (loi4 == "Aléatoire"){
      dates4 <- c(0, sort(sample(1:(t_max4-1), choix_pts4()-2, replace = FALSE)), t_max4)
    }
    if (loi4 == "Uniforme"){
      dates4 <- c(0, sort(runif(choix_pts4() -2, min = 0, max = t_max4 )), t_max4)
    }
    if (loi4 == "Exponentielle"){
      dates4 <- gene_exp(0, t_max4, choix_pts4())
    }
    
    ## Tracés
    
    
    
    if (choix_nbS4() == 1){
      plot(dates4, simulation_gamma(dates4,choix_a(),choix_b(),0), type="l",
           main = "Processus Gamma",
           xlab = "Temps en secondes",
           ylab = "Valeur approchée de G(t)"
      )
      grid()
      valeur_finale <- simulation_gamma(dates4,choix_a(),choix_b(),0)[length(dates4)]
      est_moy4 <- valeur_finale / t_max4
      
      if (c_stat == "Oui"){
        abline(0, est_moy4, col = "darkviolet", lwd = 3)
      }
    } else{
      generation_gamma <- function(dates, alpha, beta, x0, n_simulations) {
        trajectoires <- matrix(0, nrow = n_simulations, ncol = length(dates))
        for (sim in 1:n_simulations) {
          trajectoires[sim, ] <- simulation_gamma(dates, alpha, beta, x0)
        }
        
        df <- data.frame(Date = dates, t(trajectoires))
        colnames(df) <- c("Date", paste0("Simulation_", 1:n_simulations))
        
        return(list(trajectoires = trajectoires, dataframe = df))
      }
      
      # Générer plusieurs trajectoires
      
      res <- generation_gamma(dates4, choix_a(), choix_b(), 0, choix_nbS4())
      
      # Tracer les trajectoires
      matplot(dates4, t(res$trajectoires), type = "o",pch = 19, las = 1,cex = 0.5,
              lty = 1, lwd = 1.5,
              #col=rainbow(choix_nbS4()),
              col="black",
              main = "Processus Gamma",
              xlab = "Temps", ylab = "Valeur approchée de G(t)",
              panel.first = grid())
      
      valeurs_finales <- res$trajectoires[, length(dates4)]
      # Moyenne empirique (M) et Variance empirique (V)
      M_emp <- mean(valeurs_finales, na.rm = TRUE)
      V_emp <- var(valeurs_finales, na.rm = TRUE)
      
      
      # Calcul des estimateurs (Méthode des Moments)
      # b_chapeau = Moyenne / Variance
      # a_chapeau = (Moyenne * b_chapeau) / Temps
      
      if (V_emp > 0) {
        est_b <- M_emp / V_emp
        est_a <- (M_emp * est_b) / t_max4
      } else {
        est_b <- 0
        est_a <- 0
      }
      pente_estimee <- 0
      if(est_b != 0) pente_estimee <- est_a / est_b
      if (c_stat == "Oui"){
        abline(0, pente_estimee, col = "darkviolet", lwd = 3)
      }
    }
    ## Affichage du seuil
    s4 <- choix_seuil4()
    ## On vérifie si le bouton a déjà été cliqué (ou si une valeur existe)
    if (input$Run4 > 0) {
      abline(h = s4, col = "red", lwd = 2, lty = 2)
    }
    intersection_seuil <- function(df,h){
      nl <- length(df[,1])
      nc <- length(df[1,])
      cat(nl,nc)
      ech <- c()
      for (i in 2:nc){
        j <- 1
        while (j < nl){
          if (df[j,i] < h){
            j <- j + 1
          }else{
            ech <- c(ech,df[j,1])
            break
          }
        }
      }
      return(ech)
    }
    if (!is.null(input$Tps_seuil4) && input$Tps_seuil4 > 0 && input$Tps_seuil4 %% 2 != 0) {
      
      # Sécurité : Si l'utilisateur est en mode "1 seule courbe", 'res' n'existe pas.
      if (exists("res")) { 
        x <- intersection_seuil(res$dataframe, choix_seuil4()) 
        cat(x)
        if(length(x) > 0) {
          abline(v = mean(x), col = "red", lwd = 3)
          abline(v = mean(x) - sd(x), col = "darkred", lwd = 3, lty = 2)
          abline(v = mean(x) + sd(x), col = "darkred", lwd = 3, lty = 2)
          legend("topright",
                 legend = c("Dates de défaillance moyenne", "Variance des dates de défaillances"),
                 col = c("red", "darkred"),
                 lty = c(2, 2), lwd = c(3, 3), bg = "white")
        }
      }
    }
  })
  
  ##
  ## TRACÉ  POUR LE SEMI-CONDUCTEUR
  ##
  
  ## Fonction pour récupérer la valeur du seuil
  seuil_fixe <- eventReactive(input$Run, {
    return(input$Choix_seuil)
  }, ignoreNULL = FALSE)
  # Fonction pour le nombre de tracet 
  nb_tracet <-  eventReactive(input$Run,{
    return(input$Choix_nbt)
  },ignoreNULL = FALSE)
  # Fonction qui configure la sortie
  output$SimSC <- renderPlot({
    ## base de données semi-conducteurs 
    semi_cond <- read.csv2("./Semicond.csv")
    ## Choix de l'échelle 
    ech <- input$Elog
    ## Affichage du seuil
    s1 <- seuil_fixe()
    ## Tracé en échelle log-log
    if (ech == "Oui"){
      ## On définit notre échelle log-log
      abscisse <- log(semi_cond$t)
      ordonnee <- log(semi_cond$V1)
      ## Définition du graphique.
      plot(abscisse, log(semi_cond$V1),cex =.3, type = "o", pch = 19, las = 1, xlab = "log(Temps en secondes)", ylab = "log(Dégradation)")
      grid()
      ## Nombre de tracés à afficher 
      vc = c("","darkorange","darkviolet","deepskyblue","darkgreen")
      nbt <- nb_tracet()
      if (nbt > 1){
        for (k in 2:(nbt)){
          nom_col <- paste0("V",k)
          lines(abscisse, log(semi_cond[[nom_col]]), cex =.3, type = "o", pch = 19, las = 1,col = vc[k])
        }
      }
      intersection_seuil <- function(df,h){
        nl <- length(df[,1])
        nc <- length(df[1,])
        cat(nl,nc)
        ech <- c()
        for (i in 2:nc){
          j <- 1
          while (j < nl){
            if (df[j,i] < h){
              j <- j + 1
            }else{
              ech <- c(ech,df[j,1])
              break
            }
          }
        }
        return(ech)
      }
    }
    if (ech == "Non"){
      ## On définit notre échelle 
      abscisse <- semi_cond$t
      ordonnee <- semi_cond$V1
      ## Définition du graphique
      plot(abscisse, semi_cond$V1,cex =.3, type = "o", pch = 19, las = 1, xlab = "Temps en secondes", ylab = "Dégradation")
      grid()
      ## Nombre de tracés à afficher 
      vc = c("","darkorange","darkviolet","deepskyblue","darkgreen")
      nbt <- nb_tracet()
      if (nbt > 1){
        for (k in 2:(nbt)){
          nom_col <- paste0("V",k)
          lines(abscisse, semi_cond[[nom_col]], cex =.3, type = "o", pch = 19, las = 1,col = vc[k])
        }
      }
      intersection_seuil <- function(df,h){
        nl <- length(df[,1])
        nc <- length(df[1,])
        cat(nl,nc)
        ech <- c()
        for (i in 2:nc){
          j <- 1
          while (j < nl){
            if (df[j,i] < h){
              j <- j + 1
            }else{
              ech <- c(ech,df[j,1])
              break
            }
          }
        }
        return(ech)
      }
      if (!is.null(input$Tps_seuil1) && input$Tps_seuil1 > 0 && input$Tps_seuil1 %% 2 != 0){
        if (nbt > 1){
          x <- intersection_seuil(semi_cond, s1) 
          cat(x)
          if(length(x) > 0) {
            abline(v = mean(x), col = "red", lwd = 3)
            abline(v = mean(x) - sd(x), col = "darkred", lwd = 3, lty = 2)
            abline(v = mean(x) + sd(x), col = "darkred", lwd = 3, lty = 2)
            legend("topright",
                   legend = c("Dates de défaillance moyenne", "Variance des dates de défaillances"),
                   col = c("red", "darkred"),
                   lty = c(2, 2), lwd = c(3, 3), bg = "white")
        }
        }
      }
    }
    ## On vérifie si le bouton a déjà été cliqué (ou si une valeur existe)
    if (input$Run > 0) {
      abline(h = s1, col = "red", lwd = 2, lty = 2)
    }
  })
  observeEvent(input$EstSC, {
    
    # On demande à Shiny d'afficher la modale
    showModal(modalDialog(
      title = "Estimation des paramètres pour un processus de Wiener",
      withMathJax(
        p("Méthode du Maximum de Vraisemblance:"),
        br(),
        "$$ \\hat{\\mu} = 0.000383  $$", 
        "$$ \\hat{\\sigma} = 0.0210 $$",
        br(),
        p("Méthode des moments:"),
        br(),
        "$$ \\hat{\\mu} = 0.000980 $$",
        "$$ \\hat{\\sigma} =  0.0294 $$"
      ),
      
      easyClose = TRUE,
      
      footer = modalButton("Fermer")
    ))
    
  })
  
  
  ##
  ## TRACÉ POUR LE LASER
  ##
  
  seuil_fixe2 <- eventReactive(input$Run2,{
    return(input$Choix_seuil2)
  },ignoreNULL = FALSE)
  nb_tracet2 <- eventReactive(input$Run2,{
    return(input$Choix_nbt2)
  },ignoreNULL = FALSE)
  output$SimL <- renderPlot({
    # Récupération des données
    lasers <- read.csv2("./Laser.csv")
    # Récupération du choix d'échelle
    ech2 <- input$Elog2
    ## Affichage du seuil
    s2 <- seuil_fixe2()
    ## Tracé en échelle log-log
    if (ech2 == "Oui"){
      ## Tracé des courbes 
      abscissel <-log(lasers$t)
      ordonnel <- log(lasers$U1)
      ## Choix du nombre de courbes
      nbt2 <- nb_tracet2()
      plot(abscissel, log(lasers$U1),cex =.3, type = "o", pch = 19, las = 1, xlab = "log(Temps en secondes)", ylab = "log(Dégradation)")
      grid()
      cols <- c("U2", "U3", "U4", "U5", "U6", "U7", "U8", "U9")
      vc2 <- c("red", "blue", "green", "orange", "purple", "cyan", "magenta", "yellow", "brown")
      if (nbt2 > 1){
        for (k in 2:nbt2) {
          nom_col2 <- paste0("U",k)
          lines(abscissel, log(lasers[[nom_col2]]), cex = .3, type = "o", pch = 19,col = vc2[k])
        }
      }
      intersection_seuil <- function(df,h){
        nl <- length(df[,1])
        nc <- length(df[1,])
        cat(nl,nc)
        ech <- c()
        for (i in 2:nc){
          j <- 1
          while (j < nl){
            if (df[j,i] < h){
              j <- j + 1
            }else{
              ech <- c(ech,df[j,1])
              break
            }
          }
        }
        return(ech)
      }
    }
    ## Tracé en échelle non-log
    if (ech2 == "Non"){
      ## Tracé des courbes 
      abscisse <- lasers$t
      ordonne <- lasers$U1
      ## Choix du nombre de courbes
      nbt2 <- nb_tracet2()
      plot(abscisse, lasers$U1,cex =.3, type = "o", pch = 19, las = 1, xlab = "Temps en secondes", ylab = "Dégradation")
      grid()
      cols <- c("U2", "U3", "U4", "U5", "U6", "U7", "U8", "U9")
      vc2 <- c("red", "blue", "green", "orange", "purple", "cyan", "magenta", "yellow", "brown")
      if (nbt2 > 1){
        for (k in 2:nbt2) {
          nom_col2 <- paste0("U",k)
          lines(abscisse, lasers[[nom_col2]], cex = .3, type = "o", pch = 19,col = vc2[k])
        }
      }
      intersection_seuil <- function(df,h){
        nl <- length(df[,1])
        nc <- length(df[1,])
        cat(nl,nc)
        ech <- c()
        for (i in 2:nc){
          j <- 1
          while (j < nl){
            if (df[j,i] < h){
              j <- j + 1
            }else{
              ech <- c(ech,df[j,1])
              break
            }
          }
        }
        return(ech)
      }
      if (!is.null(input$Tps_seuil2) && input$Tps_seuil2 > 0 && input$Tps_seuil2 %% 2 != 0) {
        if (nbt2 > 1){
        x <- intersection_seuil(lasers, s2) 
        cat(x)
        if(length(x) > 0) {
          abline(v = mean(x), col = "red", lwd = 3)
          abline(v = mean(x) - sd(x), col = "darkred", lwd = 3, lty = 2)
          abline(v = mean(x) + sd(x), col = "darkred", lwd = 3, lty = 2)
          legend("topright",
                 legend = c("Dates de défaillance moyenne", "Variance des dates de défaillances"),
                 col = c("red", "darkred"),
                 lty = c(2, 2), lwd = c(3, 3), bg = "white")
        }
        }
      }
    }
    
    ## On vérifie si le bouton a déjà été cliqué (ou si une valeur existe)
    if (input$Run2 > 0) {
      abline(h = s2, col = "red", lwd = 2, lty = 2)
    }
  })
  observeEvent(input$EstL, {
    
    # On demande à Shiny d'afficher la modale
    showModal(modalDialog(
      title = "Estimation des paramètres",
      withMathJax(
        h4("Processus Gamma"),
        hr(),
        p("Méthode du Maximum de Vraisemblance:"),
        br(),
        "$$ \\hat{a} = 0.00204 $$", 
        "$$ \\hat{b} = 0.0127 $$",
        br(),
        p("Méthode des moments:"),
        br(),
        "$$ \\hat{a} = 0.00204 $$",
        "$$ \\hat{b} = 0.0127 $$",
        br(),
        h4("Processus Wiener"),
        hr(),
        p("Méthode du Maximum de Vraisemblance:"),
        "$$ \\hat{\\mu} = 0.00204$$",
        "$$ \\hat{\\sigma} = 0.0123$$",
        br(),
        p("Méthode des moments:"),
        br(),
        "$$ \\hat{\\mu} = 0.00191$$",
        "$$ \\hat{\\sigma} = 0.0103$$"
      ),
      
      easyClose = TRUE,
      
      footer = modalButton("Fermer")
    ))
    
  })
}


# Pour lancer l'application

shinyApp(ui = ui, server = server)