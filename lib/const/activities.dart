// Hardcoded activities list
import '../models/activity.dart';

const Map<String, Activity> activities = {
  'post_pranzo': Activity(
      name: 'Pulizia post pranzo',
      subtasks: [
        Subtask(name: 'I MIEI VESTITI SONO ASCIUTTI?'),
        Subtask(name: 'Svuota briciole'),
        Subtask(name: 'Pulizia banco'),
        Subtask(name: 'Pulizia piano induzione'),
        Subtask(name: 'Pulizia tavolo'),
        Subtask(name: 'Sciacquata + Piatti in lavastoviglie'),
        Subtask(name: 'Svuota resti organici lavabo'),
        Subtask(name: 'Panno nero per induzione'),
        Subtask(name: 'Vitamine', user: 'Gabriele'),
        Subtask(name: 'Stretching', user: 'Francesco'),
        Subtask(name: 'Lava denti', user: 'Francesco')
      ],
      frequency: ActivityFrequency.everyMeal,
      additionalSubtasks: [
        Subtask(name: 'Avvia Lavastoviglie / Svuota lavastoviglie pulita'),
        Subtask(name: 'Check vetro'),
        Subtask(name: 'Check indifferenziato'),
        Subtask(name: 'Check organico'),
        Subtask(name: 'Pezza su bidoni'),
        Subtask(
            name:
                'Passata aspirapolvere + Metti in Carica / Riordina se carico'),
        Subtask(name: 'Mettere pezze e tovaglie sporche in lavatrice'),
        Subtask(name: 'Liberare pavimenti'),
      ]),
  'post_cena': Activity(
      name: 'Pulizia post cena',
      subtasks: [
        Subtask(name: 'I MIEI VESTITI SONO ASCIUTTI?'),
        Subtask(name: 'Svuota briciole'),
        Subtask(name: 'Pulizia banco'),
        Subtask(name: 'Pulizia piano induzione'),
        Subtask(name: 'Pulizia tavolo'),
        Subtask(name: 'Sciacquata + Piatti in lavastoviglie'),
        Subtask(name: 'Svuota resti organici lavabo'),
        Subtask(name: 'Panno nero per induzione'),
        Subtask(name: 'Vitamine', user: 'Gabriele'),
        Subtask(name: 'Stretching', user: 'Francesco'),
        Subtask(name: 'Lava denti', user: 'Francesco')
      ],
      frequency: ActivityFrequency.everyMeal,
      additionalSubtasks: [
        Subtask(name: 'Avvia Lavastoviglie / Svuota lavastoviglie pulita'),
        Subtask(name: 'Check vetro'),
        Subtask(name: 'Check indifferenziato'),
        Subtask(name: 'Check organico'),
        Subtask(name: 'Pezza su bidoni'),
        Subtask(
            name:
                'Passata aspirapolvere + Metti in Carica / Riordina se carico'),
        Subtask(name: 'Mettere pezze e tovaglie sporche in lavatrice'),
        Subtask(name: 'Liberare pavimenti'),
      ]),
  'bagno': Activity(
    name: 'Pulizia bagno',
    subtasks: [
      Subtask(name: 'Bidet'),
      Subtask(name: 'Water'),
      Subtask(name: 'Lavabo + sturare se intasato'),
      Subtask(name: 'Check cestino'),
    ],
    frequency: ActivityFrequency.weekly,
  ),
  'cucina': Activity(
    name: 'Pulizia cucina profonda',
    subtasks: [
      Subtask(name: 'Pezza in forno'),
      Subtask(name: 'Svuota cibi scaduti / muffiti'),
      Subtask(name: 'Pezza su ripiani frigo'),
      Subtask(name: 'Grattugia grana'),
      Subtask(name: 'Travasa olio'),
    ],
    frequency: ActivityFrequency.weekly,
  ),
  'carta': Activity(
    name: 'Svuotare carta',
    subtasks: [Subtask(name: 'Svuota carta')],
    frequency: ActivityFrequency.weekly,
  ),
  'plastica': Activity(
    name: 'Svuotare plastica',
    subtasks: [
      Subtask(name: 'Svuota plastica'),
      Subtask(name: 'Nuovo sacchetto'),
    ],
    frequency: ActivityFrequency.weekly,
  ),
  'organico': Activity(
    name: 'Svuotare organico',
    subtasks: [
      Subtask(name: 'Svuota organico'),
      Subtask(name: 'Nuovo sacchetto'),
    ],
    frequency: ActivityFrequency.weekly,
  ),
  'scopa': Activity(
    name: 'Scopa',
    subtasks: [
      Subtask(name: 'Cucina pavimento'),
      Subtask(name: 'Cucina sedie'),
      Subtask(name: 'Corridoio'),
      Subtask(name: 'Bagno'),
      Subtask(name: 'Bagno sotto il lavabo'),
      Subtask(name: 'Camera', user: 'Francesco'),
    ],
    frequency: ActivityFrequency.weekly,
  ),
  'mocio': Activity(
    name: 'Mocio',
    subtasks: [
      Subtask(name: 'Scopa Cucina pavimento'),
      Subtask(name: 'Scopa Cucina sedie'),
      Subtask(name: 'Scopa Corridoio'),
      Subtask(name: 'Scopa Bagno'),
      Subtask(name: 'Scopa Bagno sotto il lavabo'),
      Subtask(name: 'Scopa Camera', user: 'Francesco'),
      Subtask(name: 'Cucina pavimento'),
      Subtask(name: 'Corridoio'),
      Subtask(name: 'Bagno'),
      Subtask(name: 'Bagno sotto il lavabo'),
      Subtask(name: 'Camera', user: 'Francesco'),
      Subtask(name: 'Svuota mocio'),
    ],
    frequency: ActivityFrequency.weekly,
  ),
};
