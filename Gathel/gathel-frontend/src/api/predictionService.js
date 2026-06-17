import api from "./api";

export const obtenerPredicciones = async () => {

    const response =
        await api.get("/predictions");

    return response.data;
};

export const crearPrediccion = async (data) => {

    const response =
        await api.post("/predictions", data);

    return response.data;
};