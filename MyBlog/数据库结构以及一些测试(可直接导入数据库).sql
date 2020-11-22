/*
 Navicat Premium Data Transfer

 Source Server         : 10.7.131.84
 Source Server Type    : MySQL
 Source Server Version : 50722
 Source Host           : 10.7.131.84:3306
 Source Schema         : imagedata4_uat

 Target Server Type    : MySQL
 Target Server Version : 50722
 File Encoding         : 65001

 Date: 22/11/2020 16:59:57
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for archives
-- ----------------------------
DROP TABLE IF EXISTS `archives`;
CREATE TABLE `archives`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `archiveName` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of archives
-- ----------------------------
INSERT INTO `archives` VALUES (1, '2020年10月');
INSERT INTO `archives` VALUES (2, '2020年11月');
INSERT INTO `archives` VALUES (4, '2020年11月');

-- ----------------------------
-- Table structure for article
-- ----------------------------
DROP TABLE IF EXISTS `article`;
CREATE TABLE `article`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `articleId` bigint(20) NOT NULL,
  `author` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `originalAuthor` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `articleTitle` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `articleContent` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `articleTags` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `articleType` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `articleCategories` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `publishDate` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `updateDate` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `articleUrl` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `articleTabloid` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `likes` int(11) NOT NULL,
  `lastArticleId` bigint(20) NULL DEFAULT NULL,
  `nextArticleId` bigint(20) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 23 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of article
-- ----------------------------
INSERT INTO `article` VALUES (21, 1605593386, 'lk', 'Carol_6a27', 'springboot核心原理', '# 1.基于你对springboot的理解描述一下什么是springboot\n\n它是一个服务于spring框架的框架，能够简化配置文件，快速构建web应用，\n内置tomcat，无需打包部署，直接运行。\n\n# 2.约定优于配置指的是什么？\n\nmaven 的目录结构\na) 默认有 resources 文件夹存放配置文件\nb) 默认打包方式为 jar\nspring-boot-starter-web 中默认包含 spring mvc 相关依赖以及内置的 tomcat 容器，使得构建一个 web 应用更加简单\n默认提供 application.properties/yml 文件\n默认通过 spring.profiles.active 属性来决定运行环境时读取的配置文件\nEnableAutoConfiguration 默认对于依赖的 starter 进行自动\n\n# 3.@SpringBootApplication由哪几个注解组成，这几个注解分别表示什么作用\n\nSpringBootApplication 本质上是由 3 个注解组成，分别是\n\n@Configuration\n@EnableAutoConfiguration\n@ComponentScan\n@Configuration：\n在启动类里面标注了@Configuration，意味着它其实也是一个 IoC\n容器的配置类\n\n@EnableAutoConfiguration：\nspringboot 应用把所有符合条件的@Configuration 配置\n都加载到当前 SpringBoot 创建并使用的 IoC 容器中。\n\n@ComponentScan：\nComponentScan 默认会扫描当前 package 下的的所有加\n了@Component 、@Repository、@Service、@Controller的类到 IoC 容器中；\n\n# 4.springboot自动装配的实现原理\n\n\nimage.png\n\n如果是之前的spring中使用redis需要在xml定义bean,现在只需要依赖一个spring-boot-starter-data-redis\n的jar包,jar中定义了RedisConfiguration,当启动的时候spring会自动装载RedisConfiguration,那spring是如何知道配置类在哪里的呢?RedisConfiguration类的路径放在了classpath*META-INF/spring.factories的文件中,spring会加载这个文件中配置的configuration\n\n（1）SpringApplication.run(AppConfig.class,args);执行流程中有refreshContext(context);这句话.\n（2）refreshContext(context);内部会解析我们的配置类上的标签.实现自动装配功能的注解@EnableAutoConfiguration\n（3）会解析@EnableAutoConfiguration这个注解里面的@Import引入的配置类.AutoConfigurationImportSelector\n（4）AutoConfigurationImportSelector这个类中有这个方法.SpringFactoriesLoader.loadFactoryNames(getSpringFactoriesLoaderFactoryClass(), getBeanClassLoader());\n（5）SpringFactoriesLoader.loadFactoryNames的作用就是读取jar包中的/项目中的META-INF/spring.factories文件.\n（6）spring.factories配置了要自动装配的Configuration类\n\n# 5.spring中的spi机制的原理是什么？\n\nSPI的全名为Service Provider Interface，为某个接口寻找服务实现的机制。\n当服务的提供者，提供了服务接口的一种实现之后，在jar包的META-INF/services/目录里同时创建一个以服务接口命名的文件。该文件里就是实现该服务接口的具体实现类。而当外部程序装配这个模块的时候，就能通过该jar包META-INF/services/里的配置文件找到具体的实现类名，并装载实例化，完成模块的注入。通过这个约定，就不需要把服务放在代码中了，通过模块被装配的时候就可以发现服务类了。\n\n在springboot的自动装配过程中，最终会加载META-INF/spring.factories文件，而加载的过程是由SpringFactoriesLoader加载的。从CLASSPATH下的每个Jar包中搜寻所有META-INF/spring.factories配置文件，然后将解析properties文件，找到指定名称的配置后返回。需要注意的是，其实这里不仅仅是会去ClassPath路径下查找，会扫描所有路径下的Jar包，只不过这个文件只会在Classpath下的jar包中。\n\n通过spi技术可以自定义starter,在自定义的配置文件META-INF/spring.factories中加入实现类,依赖这个starter的项目就会扫描jar包下的配置,找到实现类进行装载实例化\n\n\n作者：Carol_6a27\n链接：https://www.jianshu.com/p/f6ec46bd34a2\n来源：简书\n著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。', 'SpringBoot,转载', '转载', 'SpringBoot', '2020-11-17', '2020-11-17', 'https://www.jianshu.com/p/f6ec46bd34a2', '1.基于你对springboot的理解描述一下什么是springboot它是一个服务于spring框架的框架，能够简化配置文件，快速构建web应用，内置tomcat，无需打包部署，直接运行。2.约定优于配置指的是什么？maven的目录结构a)默认有resources文件夹存放配置文件b)默认打包方式为jarspring-boot-starter-web中默认包含springmvc相关依赖以及...', 2, 0, 1605621462);
INSERT INTO `article` VALUES (22, 1605621462, '林奎', '林奎', 'spring Ioc（DI）的理解', '# 自己关于spring Ioc的理解：\n\n类和其依赖类的关系可以描述为公司与雇员的关系，spring提供的Ioc容器相当于人力资源公司（中介）。当一个公司需要新的员工或者其他什么资源时，传统的做法是公司自己进行招聘，有了中介之后，公司联系中介公司说我要什么样的员工（类），员工需要有什么样的技能（类的依赖类或者其他资源）。如果中介公司有这样的员工，交给公司。公司主动找人的过程就变成接受中介找到的员工，公司的主动权变为了被动接受。这就是控制反转。下面是大牛写的关于Ioc的介绍，引自：http://jinnianshilongnian.iteye.com/blog/1413846\n## 1. Ioc是什么？\nIoc—Inversion of Control，即“控制反转”，不是什么技术，而是一种设计思想。在Java开发中，Ioc意味着将你设计好的对象交给容器控制，而不是传统的在你的对象内部直接控制。如何理解好Ioc呢？理解好Ioc的关键是要明确“谁控制谁，控制什么，为何是反转（有反转就应该有正转了），哪些方面反转了”，那我们来深入分析一下：\n谁控制谁，控制什么： 传统Java SE程序设计，我们直接在对象内部通过new进行创建对象，是程序主动去创建依赖对象；而IoC是有专门一个容器来创建这些对象，即由Ioc容器来控制对象的创建；谁控制谁？当然是IoC 容器控制了对象；控制什么？那就是主要控制了外部资源获取（不只是对象包括比如文件等）。\n\n为何是反转，哪些方面反转了：有反转就有正转，传统应用程序是由我们自己在对象中主动控制去直接获取依赖对象，也就是正转；而反转则是由容器来帮忙创建及注入依赖对象；为何是反转？因为由容器帮我们查找及注入依赖对象，对象只是被动的接受依赖对象，所以是反转；哪些方面反转了？依赖对象的获取被反转了。\n## 2. Ioc能做什么\nIoC不是一种技术，只是一种思想，一个重要的面向对象编程的法则，它能指导我们如何设计出松耦合、更优良的程序。传统应用程序都是由我们在类内部主动创建依赖对象，从而导致类与类之间高耦合，难于测试；有了IoC容器后，把创建和查找依赖对象的控制权交给了容器，由容器进行注入组合对象，所以对象与对象之间是松散耦合，这样也方便测试，利于功能复用，更重要的是使得程序的整个体系结构变得非常灵活。\n\n其实IoC对编程带来的最大改变不是从代码上，而是从思想上，发生了“主从换位”的变化。应用程序原本是老大，要获取什么资源都是主动出击，但是在IoC/DI思想中，应用程序就变成被动的了，被动的等待IoC容器来创建并注入它所需要的资源了。\n\nIoC很好的体现了面向对象设计法则之一—— 好莱坞法则：“别找我们，我们找你”；即由IoC容器帮对象找相应的依赖对象并注入，而不是由对象主动去找。\n\n## 3. IoC和DI\nDI—Dependency Injection，即“依赖注入”：是组件之间依赖关系由容器在运行期决定，形象的说，即由容器动态的将某个依赖关系注入到组件之中。依赖注入的目的并非为软件系统带来更多功能，而是为了提升组件重用的频率，并为系统搭建一个灵活、可扩展的平台。通过依赖注入机制，我们只需要通过简单的配置，而无需任何代码就可指定目标需要的资源，完成自身的业务逻辑，而不需要关心具体的资源来自何处，由谁实现。\n\n理解DI的关键是：“谁依赖谁，为什么需要依赖，谁注入谁，注入了什么”，那我们来深入分析一下：\n\n谁依赖于谁：当然是应用程序依赖于IoC容器；\n\n为什么需要依赖：应用程序需要IoC容器来提供对象需要的外部资源；\n\n谁注入谁：很明显是IoC容器注入应用程序某个对象，应用程序依赖的对象；\n\n注入了什么：就是注入某个对象所需要的外部资源（包括对象、资源、常量数据）。\n\nIoC和DI由什么关系呢？其实它们是同一个概念的不同角度描述，由于控制反转概念比较含糊（可能只是理解为容器控制对象这一个层面，很难让人想到谁来维护对象关系），所以2004年大师级人物Martin Fowler又给出了一个新的名字：“依赖注入”，相对IoC 而言，“依赖注入”明确描述了“被注入对象依赖IoC容器配置依赖对象”。\n\n注：如果想要更加深入的了解IoC和DI，请参考大师级人物Martin Fowler的一篇经典文章《Inversion of Control Containers and the Dependency Injection pattern》，原文地址：http://www.martinfowler.com/articles/injection.html。\n\n', 'spring,框架,java,原创', '原创', 'SpringBoot', '2020-11-17', '2020-11-17', 'http://localhost:8888/article/1605621462', '自己关于springIoc的理解：类和其依赖类的关系可以描述为公司与雇员的关系，spring提供的Ioc容器相当于人力资源公司（中介）。当一个公司需要新的员工或者其他什么资源时，传统的做法是公司自己进行招聘，有了中介之后，公司联系中介公司说我要什么样的员工（类），员工需要有什么样的技能（类的依赖类或者其他资源）。如果中介公司有这样的员工，交给公司。公司主动找人的过程就变成接受中介找到的员工，...', 5, 1605593386, 0);

-- ----------------------------
-- Table structure for article_likes_record
-- ----------------------------
DROP TABLE IF EXISTS `article_likes_record`;
CREATE TABLE `article_likes_record`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `articleId` bigint(20) NOT NULL,
  `likerId` int(11) NOT NULL,
  `likeDate` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `isRead` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 31 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of article_likes_record
-- ----------------------------
INSERT INTO `article_likes_record` VALUES (29, 1605621462, 1, '2020-11-19 23:35', 0);
INSERT INTO `article_likes_record` VALUES (30, 1605593386, 1, '2020-11-19 23:53', 0);

-- ----------------------------
-- Table structure for categories
-- ----------------------------
DROP TABLE IF EXISTS `categories`;
CREATE TABLE `categories`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `categoryName` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of categories
-- ----------------------------
INSERT INTO `categories` VALUES (1, '我的故事');
INSERT INTO `categories` VALUES (2, 'SpringBoot');

-- ----------------------------
-- Table structure for comment_likes_record
-- ----------------------------
DROP TABLE IF EXISTS `comment_likes_record`;
CREATE TABLE `comment_likes_record`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `articleId` bigint(20) NOT NULL,
  `pId` int(11) NOT NULL,
  `likerId` int(11) NOT NULL,
  `likeDate` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of comment_likes_record
-- ----------------------------
INSERT INTO `comment_likes_record` VALUES (8, 1605621462, 16, 1, '2020-11-17 23:00');

-- ----------------------------
-- Table structure for comment_record
-- ----------------------------
DROP TABLE IF EXISTS `comment_record`;
CREATE TABLE `comment_record`  (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `pId` bigint(20) NOT NULL,
  `articleId` bigint(20) NOT NULL,
  `answererId` int(11) NOT NULL,
  `respondentId` int(11) NOT NULL,
  `commentDate` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `likes` int(255) NOT NULL,
  `commentContent` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `isRead` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of comment_record
-- ----------------------------
INSERT INTO `comment_record` VALUES (16, 0, 1605621462, 16, 1, '2020-11-20 11:12', 0, '11', 1);

-- ----------------------------
-- Table structure for feedback
-- ----------------------------
DROP TABLE IF EXISTS `feedback`;
CREATE TABLE `feedback`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `feedbackContent` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `contactInfo` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `personId` int(11) NOT NULL,
  `feedbackDate` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of feedback
-- ----------------------------
INSERT INTO `feedback` VALUES (1, '染发鬼地方', '', 1, '2020-11-17 21:49:07');
INSERT INTO `feedback` VALUES (2, '11111111111111111111', '', 16, '2020-11-20 11:11:23');

-- ----------------------------
-- Table structure for friendlink
-- ----------------------------
DROP TABLE IF EXISTS `friendlink`;
CREATE TABLE `friendlink`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `blogger` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `url` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of friendlink
-- ----------------------------
INSERT INTO `friendlink` VALUES (2, 'Li Pan\s 博客', 'http://www.lipan.xyz');
INSERT INTO `friendlink` VALUES (3, '陈晓雷个人博客', 'http://www.csxll.top');
INSERT INTO `friendlink` VALUES (4, 'SAn Blog', 'https://sanii.cn');
INSERT INTO `friendlink` VALUES (5, '会打篮球的程序猿', 'http://www.liuzhaopo.top');
INSERT INTO `friendlink` VALUES (6, 'Mr_曾中杰', 'https://www.zengzhongjie.com');
INSERT INTO `friendlink` VALUES (7, '去当CTO', 'https://www.qdcto.com');
INSERT INTO `friendlink` VALUES (8, 'Face2Object', 'https://www.bossding.com.cn');
INSERT INTO `friendlink` VALUES (9, '小海博客', 'https://www.celess.cn');
INSERT INTO `friendlink` VALUES (10, '枫之羽', 'http://fzhiy.com');
INSERT INTO `friendlink` VALUES (12, '百度', 'http://www.baidu.com');

-- ----------------------------
-- Table structure for leave_message_likes_record
-- ----------------------------
DROP TABLE IF EXISTS `leave_message_likes_record`;
CREATE TABLE `leave_message_likes_record`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pageName` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `pId` int(11) NOT NULL,
  `likerId` int(11) NOT NULL,
  `likeDate` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of leave_message_likes_record
-- ----------------------------
INSERT INTO `leave_message_likes_record` VALUES (11, 'tags', 20, 1, '2020-11-19 23:52');
INSERT INTO `leave_message_likes_record` VALUES (12, 'tags', 19, 1, '2020-11-19 23:52');
INSERT INTO `leave_message_likes_record` VALUES (13, 'tags', 16, 1, '2020-11-19 23:52');

-- ----------------------------
-- Table structure for leave_message_record
-- ----------------------------
DROP TABLE IF EXISTS `leave_message_record`;
CREATE TABLE `leave_message_record`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pageName` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `pId` int(255) NOT NULL,
  `answererId` int(11) NOT NULL,
  `respondentId` int(11) NOT NULL,
  `leaveMessageDate` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `likes` int(11) NOT NULL,
  `leaveMessageContent` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 26 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of leave_message_record
-- ----------------------------
INSERT INTO `leave_message_record` VALUES (14, 'categories', 0, 1, 1, '2020-11-17 13:53', 0, '分类留言测试');
INSERT INTO `leave_message_record` VALUES (15, 'archives', 0, 1, 1, '2020-11-17 13:53', 0, '归档留言');
INSERT INTO `leave_message_record` VALUES (16, 'tags', 0, 1, 1, '2020-11-17 13:53', 1, '标签留言');
INSERT INTO `leave_message_record` VALUES (17, 'update', 0, 1, 1, '2020-11-17 13:53', 0, '更新留言');
INSERT INTO `leave_message_record` VALUES (18, 'friendlylink', 0, 1, 1, '2020-11-17 13:54', 0, '博客测试');
INSERT INTO `leave_message_record` VALUES (19, 'tags', 0, 1, 1, '2020-11-17 22:13', 1, '522');
INSERT INTO `leave_message_record` VALUES (20, 'tags', 0, 1, 1, '2020-11-17 22:13', 1, 'dfsf');
INSERT INTO `leave_message_record` VALUES (21, 'archives', 0, 1, 1, '2020-11-17 22:18', 0, 'rf');
INSERT INTO `leave_message_record` VALUES (22, 'mystory', 0, 1, 1, '2020-11-17 23:01', 0, '试试');
INSERT INTO `leave_message_record` VALUES (23, 'aboutme', 0, 16, 1, '2020-11-20 11:07', 0, 'uuu');
INSERT INTO `leave_message_record` VALUES (24, 'aboutme', 0, 1, 1, '2020-11-20 23:08', 0, '是');
INSERT INTO `leave_message_record` VALUES (25, 'aboutme', 24, 1, 1, '2020-11-20 23:12', 0, 'kliuj');

-- ----------------------------
-- Table structure for privateword
-- ----------------------------
DROP TABLE IF EXISTS `privateword`;
CREATE TABLE `privateword`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `privateWord` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `publisherId` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `replierId` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `replyContent` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `publisherDate` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of privateword
-- ----------------------------
INSERT INTO `privateword` VALUES (8, '悄悄话测试', '1', '1', '我', '2020-11-17 14:13:32');

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES (1, 'ROLE_USER');
INSERT INTO `role` VALUES (2, 'ROLE_ADMIN');
INSERT INTO `role` VALUES (3, 'ROLE_SUPERADMIN');

-- ----------------------------
-- Table structure for tags
-- ----------------------------
DROP TABLE IF EXISTS `tags`;
CREATE TABLE `tags`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tagName` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `tagSize` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 24 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tags
-- ----------------------------
INSERT INTO `tags` VALUES (1, '随笔感悟', 15);
INSERT INTO `tags` VALUES (4, 'SpringBoot', 17);
INSERT INTO `tags` VALUES (5, '个人博客', 18);
INSERT INTO `tags` VALUES (18, '原创', 20);
INSERT INTO `tags` VALUES (20, '转载', 20);
INSERT INTO `tags` VALUES (21, 'spring', 17);
INSERT INTO `tags` VALUES (22, '框架', 17);
INSERT INTO `tags` VALUES (23, 'java', 17);

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `phone` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `gender` char(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `trueName` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `birthday` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `personalBrief` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `avatarImgUrl` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `recentlyLanded` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, '15313140874', '林奎', '572153b0ba84633c15dfb627180a869a', 'male', '林奎', '1995-05-19', '275222070@qq.com', '', '../img/wx.png', '2020-11-22 16:43:18');
INSERT INTO `user` VALUES (16, '15313140873', 'lk', '572153b0ba84633c15dfb627180a869a', 'male', NULL, NULL, NULL, NULL, '../img/noLogin_male.jpg', '2020-11-20 10:14:24');

-- ----------------------------
-- Table structure for user_role
-- ----------------------------
DROP TABLE IF EXISTS `user_role`;
CREATE TABLE `user_role`  (
  `User_id` int(11) NOT NULL,
  `Role_id` int(11) NOT NULL
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_role
-- ----------------------------
INSERT INTO `user_role` VALUES (1, 1);
INSERT INTO `user_role` VALUES (1, 3);
INSERT INTO `user_role` VALUES (16, 3);
INSERT INTO `user_role` VALUES (16, 1);

-- ----------------------------
-- Table structure for visitor
-- ----------------------------
DROP TABLE IF EXISTS `visitor`;
CREATE TABLE `visitor`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `visitorNum` bigint(20) NOT NULL,
  `pageName` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 25 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of visitor
-- ----------------------------
INSERT INTO `visitor` VALUES (1, 585, 'totalVisitor');
INSERT INTO `visitor` VALUES (2, 36, 'visitorVolume');
INSERT INTO `visitor` VALUES (3, 0, 'article/1532884460');
INSERT INTO `visitor` VALUES (5, 1, 'article/1533196734');
INSERT INTO `visitor` VALUES (22, 1, 'article/1605589930');
INSERT INTO `visitor` VALUES (23, 6, 'article/1605593386');
INSERT INTO `visitor` VALUES (24, 11, 'article/1605621462');

SET FOREIGN_KEY_CHECKS = 1;
