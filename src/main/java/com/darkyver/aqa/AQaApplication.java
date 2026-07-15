package com.darkyver.aqa;

import com.vaadin.flow.component.button.Button;
import com.vaadin.flow.component.grid.Grid;
import com.vaadin.flow.component.html.Header;
import com.vaadin.flow.component.orderedlayout.VerticalLayout;
import com.vaadin.flow.component.textfield.TextField;
import com.vaadin.flow.router.Route;
import lombok.AllArgsConstructor;
import lombok.Data;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import com.vaadin.flow.component.dependency.StyleSheet;
import com.vaadin.flow.component.page.AppShellConfigurator;

@SpringBootApplication
@StyleSheet("styles.css")
public class AQaApplication implements AppShellConfigurator {
    public static void main(String[] args) {
        SpringApplication.run(AQaApplication.class, args);
    }
}

// Страница 1: Кнопки
@Route("")
class MainView extends VerticalLayout {

    public MainView() {
        Header header = new Header();
        header.setText("Первая версия всегда такая");
        add(header);
        add(new Button("На главную", e -> getUI().ifPresent(ui -> ui.navigate(""))));
        add(new Button("Таблица", e -> getUI().ifPresent(ui -> ui.navigate("table"))));
        add(new Button("Форма", e -> getUI().ifPresent(ui -> ui.navigate("form"))));
    }
}

// Страница 2: Таблица
@Route("table")
class TableView extends VerticalLayout {

    public TableView() {
        Grid<Person> grid = new Grid<>(Person.class, false);
        grid.addColumn(Person::getName).setHeader("Имя");
        grid.addColumn(Person::getAge).setHeader("Возраст");
        grid.setItems(new Person("Иван", 25), new Person("Мария", 30));
        add(grid, new Button("Назад", e -> getUI().ifPresent(ui -> ui.navigate(""))));
    }
}

// Страница 3: Форма с полями
@Route("form")
class FormView extends VerticalLayout {

    public FormView() {
        TextField nameField = new TextField("Имя");
        TextField emailField = new TextField("Email");
        Button saveButton = new Button("Сохранить", e -> {
            System.out.println("Сохранено: " + nameField.getValue() + ", " + emailField.getValue());
        });
        add(nameField, emailField, saveButton, new Button("Назад", e -> getUI().ifPresent(ui -> ui.navigate(""))));
    }
}

// Модель
@Data
@AllArgsConstructor
class Person {

    private String name;

    private int age;
}
