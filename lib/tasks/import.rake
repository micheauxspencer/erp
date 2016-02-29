namespace :import do
  desc "TODO"
  task insert_db_report: :environment do
    evaluate_all = {
      js_jk: { 
        v1: {
          name: "PERSONAL PLANNING - Intellectual Development", 
          mark_type: "0",
          evaluates: [ "Is able to make choices and carry out plans",
                       "Understands the importance of health and safety"
          ]
        },
        v2: {
          name: "LANGUAGE ARTS -- Intellectual Development",
          mark_type: "0", 
          evaluates: [ "Able to express thoughts and feelings orally",
                        "Contributes to discussions and lessons",
                        "Listens attentively",
                        "Displays a positive attitude towards books",
                        "Applies a variety of early reading skills(such as picture clues, scans left-to-right, patterns, rhymes, sequence of, events, retells stories)",
                        "Draws pictures to convey meaning",
                        "Shows an interest in writing",
                        "Is able to print own name legibly",
                        "Is able to print/write some letters and numbers legibly",
                        "Responds to reading and viewing in a variety of ways, such as discussions, drawing, drama and painting",
                        "Knows letter names",
                        "Knows sounds of some letters" 
          ]
        },
        v3: {
          name: "MATHEMATICS - Intellectual Development", 
          mark_type: "0",
          evaluates: [ "Is able to sort and classify",
                        "Is able to count objects",
                        "Recognizes basic geometric shapes",
                        "Recognizes, continues and creates patterns",
                        "Understands numerals and the quantity they represent",
                        "Understands new concepts"
          ]
        },
        v4: {
          name: "SOCIAL STUDIES - Intellectual Development", 
          mark_type: "0",
          evaluates: [ "Demonstrates interest in learning about the world around herself/himself"
          ]
        },
        v5: {
          name: "SCIENCE -- Intellectual Development", 
          mark_type: "0",
          evaluates: [  "Demonstrates curiosity about the world of science",
                        "Understands simple scientific concepts",
                        "Discusses and records observations"
          ]
        },
        v6: {
          name: "FINE ARTS -- Aesthetic and Artistic Development", 
          mark_type: "0",
          evaluates: [ "Shows interest in art activities", 
                        "Shows interest in musical activities", 
                        "Shows interest in drama activities"
          ]
        },
        v7: {
          name: "PHYSICAL EDUCATION -- Physical Development", 
          mark_type: "0",
          evaluates: [ "Demonstrates small muscle control (such as with pencil, scissors, small manipulatives ...)",
                        "Participates in physical activities",
                        "Demonstrates good sportsmanship",
                        "Demonstrates skill in activities (such as running, skipping, throwing, catching ?)",
                        "Considers the safety of self and others",
                        "Understands and follows rules of simple games"
          ]
        },
        v8: {
          name: "SOCIAL RESPONSIBILITY -- Social and Emotional Development", 
          mark_type: "0",
          evaluates: [ "Is considerate and respectful of others",
                        "Demonstrates a positive self-concept",
                        "Accepts learning challenges",
                        "Finds ways to resolve conflicts and solve problems",
                        "Accepts responsibility for own actions",
                        "Maintains focus during group activities",
                        "Cares for personal and school property",
                        "Identifies and practices effective work habits",
                        "Works and plays cooperatively with others",
                        "Works independently when necessary",
                        "Follows classroom routines",
                        "Participates in activities"
          ]
        }
      },
      g1_g3: { 
       v1: {
          name: "PERSONAL PLANNING - Intellectual Development", 
          mark_type: "0",
          evaluates: [ "Is able to make choices and carry out plans",
                       "Is learning to set goals for personal growth",
                       "Is learning about the importance of healthy life choices and personal safety",
                       "Is developing an awareness of own strengths and interests"
          ]
        },
        v2: {
          name: "LANGUAGE ARTS -- Intellectual Development", 
          mark_type: "0",
          evaluates: [ "Contributes to discussions and lessons",
                       "Expresses ideas clearly when speaking",
                       "Listens with understanding",
                       "Displays a positive attitude towards books and reading",
                       "Applies a variety of strategies to read",
                       "Reads with understanding",
                       "Reads with fluency and expression",
                       "Is able to print/write letters and numbers legibly",
                       "Expresses ideas clearly in writing",
                       "Writes with fluency",
                       "Applies a variety of strategies to spell",
                       "Proofreads own writing and makes necessary changes",
                       "ENGLISH: recognizes, understands and uses oral and written vocabulary to communicate" 
          ]
        },
        v3: {
          name: "MATHEMATICS - Intellectual Development", 
          mark_type: "0",
          evaluates: [ "Understands and applies new concepts (Fractions, Ratios, Percentage)",
                      "Understands numbers and the quantities they represent (Measurement, Decimals)",
                      "Recognizes, continues and creates patterns (Geometry)",
                      "Makes reasonable estimates (Data Management, Probability)",
                      "Uses a variety of strategies to solve problems (Reasoning)",
                      "Understands basic number operations (Numeracy)",
                      "Recalls basic facts (Algebra)"
          ]
        },
        v4: {
          name: "SOCIAL STUDIES - Intellectual Development", 
          mark_type: "0",
          evaluates: [ "Demonstrates interest in learning about people, places and times",
                       "Understands concepts"
          ]
        },
        v5: {
          name: "SCIENCE -- Intellectual Development", 
          mark_type: "0",
          evaluates: [  "Demonstrates curiosity",
                        "Understands concepts",
                        "Observes and records observations"
          ]
        },
        v6: {
          name: "FINE ARTS -- Aesthetic and Artistic Development", 
          mark_type: "0",
          evaluates: [ "Shows interest in art activities",
                       "Demonstrates growth in artistic skills",
                       "Shows interest in drama activities",
                       "Shows interest in musical activities",
                       "Demonstrates growth in musical skills"
          ]
        },
        v7: {
          name: "PHYSICAL EDUCATION -- Physical Development", 
          mark_type: "0",
          evaluates: [ "Participates willingly in physical activities",
                        "Understands and follows rules of games",
                        "Considers the safety of self and others",
                        "Demonstrates skill in movement activities and with equipment"
          ]
        },
        v8: {
          name: "SOCIAL RESPONSIBILITY -- Social and Emotional Development", 
          mark_type: "0",
          evaluates: [ "Is considerate and respectful of others",
                        "Demonstrates a positive self-concept",
                        "Accepts learning challenges",
                        "Uses appropriate strategies to resolve conflicts",
                        "Accepts responsibility for own actions",
                        "Maintains focus",
                        "Cares for personal and school property",
                        "Works independently when necessary",
                        "Works and plays cooperatively with others",
                        "Completes assignments",
                        "Follows directions",
                        "Follows class and school rules and routines",
                        "Participates in activities"
          ]
        }
      },
      g4_g6: { 
        v1: {
          name: "LANGUAGE ARTS", 
          mark_type: "1",
          evaluates: [ "Reads with understanding",
                        "Uses the writing process for a variety of audiences and purposes",
                        "Effectively communicates oral information",
                        "Analyzes and creates media texts" 
          ]
        },
        v2: {
          name: "MATHEMATICS - Intellectual Development", 
          mark_type: "1",
          evaluates: [ "Understands and applies new concepts (Fractions, Ratios, Percentage)",
                        "Understands numbers and the quantities they represent (Measurement, Decimals)",
                        "Recognizes, continues and creates patterns (Geometry)",
                        "Makes reasonable estimates (Data Management, Probability)",
                        "Uses a variety of strategies to solve problems (Reasoning)",
                        "Understands basic number operations (Numeracy)",
                        "Recalls basic facts (Algebra)" 
          ]
        },
        v3: {
          name: "SOCIAL STUDIES", 
          mark_type: "1",
          evaluates: [ "Understands concepts and facts in the content area",
                        "Acquires and evaluates information and ideas",
                        "Demonstrates skill with maps and diagrams" 
          ]
        },
        v4: {
          name: "SCIENCE", 
          mark_type: "1",
          evaluates: [ "Understands concepts of content area",
                        "Applies scientific principles" 
          ]
        },
        v5: {
          name: "ART / DRAMA", 
          mark_type: "1",
          evaluates: [ "Demonstrates skill development",
                        "Participates in all activities"
          ]
        },
        v6: {
          name: "PHYSICAL EDUCATION", 
          mark_type: "1",
          evaluates: [ "Demonstrates skill development",
                        "Participates in all activities",
                        "Demonstrates etiquette and fair play" 
          ]
        },
        v7: {
          name: "FRENCH (CORE)", 
          mark_type: "1",
          evaluates: [ "Recognizes, understands and uses vocabulary to communicate",
                        "Participates in all activities"
          ]
        },
        v8: {
          name: "PERSONAL PLANNING", 
          mark_type: "1",
          evaluates: [ "Sets, monitors and evaluates personal goals",
                        "Demonstrates connections between own strengths, interests and career choices",
                        "Demonstrates an awareness of healthy life choices"
          ]
        },
        v9: {
          name: "WORK HABITS", 
          mark_type: "0",
          evaluates: [ "Organizes time",
                        "Organizes materials and written work",
                        "Completes assignments when due",
                        "Produces legible and neat work",
                        "Works independently"
          ]
        },
        v10: {
          name: "PERSONAL & SOCIAL DEVELOPMENT", 
          mark_type: "0",
          evaluates: [ "Demonstrates responsibility and reliability",
                        "Interacts with others cooperatively",
                        "Demonstrates appropriate behaviour"
          ]
        }
      },
      g7_g8: { 
        v1: {
          name: "LANGUAGE ARTS", 
          mark_type: "1",
          evaluates: [ "Reads with understanding",
                        "Uses the writing process for a variety of audiences and purposes",
                        "Effectively communicates oral information",
                        "Analyzes and creates media texts" 
          ]
        },
        v2: {
          name: "MATHEMATICS - Intellectual Development", 
          mark_type: "1",
          evaluates: [ "Understands and applies new concepts (Fractions, Ratios, Percentage)",
                        "Understands numbers and the quantities they represent (Measurement, Decimals)",
                        "Recognizes, continues and creates patterns (Geometry)",
                        "Makes reasonable estimates (Data Management, Probability)",
                        "Uses a variety of strategies to solve problems (Reasoning)",
                        "Understands basic number operations (Numeracy)",
                        "Recalls basic facts (Algebra)" 
          ]
        },
        v3: {
          name: "HISTORY/GEOGRAPHY", 
          mark_type: "1",
          evaluates: [ "Understands concepts of content area",
                       "Applies scientific principles" 
          ]
        },
        v4: {
          name: "SCIENCE", 
          mark_type: "1",
          evaluates: [ "Understands concepts of content area",
                       "Applies scientific principles" 
          ]
        },
        v5: {
          name: "ART / DRAMA", 
          mark_type: "1",
          evaluates: [ "Demonstrates skill development",
                       "Participates in all activities" 
          ]
        },
        v6: {
          name: "PHYSICAL EDUCATION", 
          mark_type: "1",
          evaluates: [ "Demonstrates skill development",
                        "Participates in all activities",
                        "Demonstrates etiquette and fair play" 
          ]
        },
        v7: {
          name: "FRENCH (CORE)", 
          mark_type: "1",
          evaluates: [ "Recognizes, understands and uses vocabulary to communicate",
                        "Participates in all activities"
          ]
        },
        v8: {
          name: "PERSONAL PLANNING", 
          mark_type: "1",
          evaluates: [ "Sets, monitors and evaluates personal goals",
                        "Demonstrates connections between own strengths, interests and career choices",
                        "Demonstrates an awareness of healthy life choices" 
          ]
        },
        v9: {
          name: "WORK HABITS", 
          mark_type: "0",
          evaluates: [ "Organizes time",
                        "Organizes materials and written work",
                        "Completes assignments when due",
                        "Produces legible and neat work",
                        "Works independently"
          ]
        },
        v10: {
          name: "PERSONAL & SOCIAL DEVELOPMENT", 
          mark_type: "0",
          evaluates: [ "Demonstrates responsibility and reliability",
                        "Interacts with others cooperatively",
                        "Demonstrates appropriate behaviour" 
          ]
        }
      }
    }

    evaluate_all.each do |key, value|
      report_template = ReportTemplate.where( name: key ).first
      if report_template.present?
        value.each do |k,v|
          evaluate_type = EvaluateType.create!( name: v[:name].to_s, report_template_id: report_template.id)
          v[:evaluates].each do |evaluate_name|
            Evaluate.create!(name: evaluate_name, evaluate_type_id: evaluate_type.id, mark_type: v[:mark_type] )
          end
        end
      end
    end

    evaluate_no_types = {
      js_jk: { 
        evaluates: ["This student is meeting the expected level of development for his/her age range. (If No, see Comment)",
                    "This student is on a modified program (If Yes, see Comment)"]
      },
      g1_g3: { 
        evaluates: ["This student is on a modified program (Y/N If Yes, see Comment)"]
      },
      g4_g6: { 
        evaluates: ["This student is on a modified program (Y/N If Yes, see Comment)"]
      },
      g7_g8: { 
        evaluates: ["This student is on a modified program (Y/N If Yes, see Comment)"]
      }
    }

    evaluate_no_types.each do |key, value|
      report_template = ReportTemplate.where( name: key ).first
      if report_template.present?
        value[:evaluates].each do |evaluate_name|
          Evaluate.create!(name: evaluate_name, report_template_id: report_template.id)
        end
      end
    end

  end

  task update_db_report_46: :environment do
    report_template = ReportTemplate.find_by_name("g4_g6")
    evaluates = Evaluate.where("evaluate_type_id IN (?)", report_template.evaluate_types.map(&:id)).where(mark_type: 1)
    evaluates.each { |evaluate| evaluate.update_attributes({ mark_type: 0 })}
  end

  task update_db_report_13: :environment do
    report_template = ReportTemplate.find_by_name("g1_g3")
    report_template.evaluates.delete_all
    Evaluate.create!(name: "This student is meeting the expected level of development for his/her age range. (If No, see Comment)", report_template_id: report_template.id)
    Evaluate.create!(name: "This student is on a modified program (Y/N If Yes, see Comment)", report_template_id: report_template.id)
  end

end


