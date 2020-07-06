Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C111C215799
	for <lists+linux-nvdimm@lfdr.de>; Mon,  6 Jul 2020 14:50:54 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 101E411068192;
	Mon,  6 Jul 2020 05:50:53 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=62.140.7.102; helo=de-smtp-delivery-102.mimecast.com; envelope-from=luis.chamberlain@suse.com; receiver=<UNKNOWN> 
Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [62.140.7.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 3B57611068191
	for <linux-nvdimm@lists.01.org>; Mon,  6 Jul 2020 05:50:50 -0700 (PDT)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2051.outbound.protection.outlook.com [104.47.14.51]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-18-kyQW1u4ePpGd2mFQWuazlQ-1; Mon, 06 Jul 2020 14:50:46 +0200
X-MC-Unique: kyQW1u4ePpGd2mFQWuazlQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Av40yiNvxzuZfnHj2Z3K6/vnqpls4rs9Cpef7mhM58i5alcbEDFx73mndTCRtJj2Uo7QwABIYXX4KaqJjsD8dHsUQsOy0e1ACKDXPzMOCU9mJ4wCPeHZniLcZkT8Nd2JMK8tFk9FeN4V6dQ7V0F6/nEFrRSTfMEjjYeGyEETehcZrxVc3SJsXhtk4WgwptoDoOXDRIwzmcwMv0h5X6ZietaMxJ51DicYI0vz+1bLt3Iz6FsdZyX8SYMXClffqhZjJJZ5FgRJHxNnRTMDjoUii5Eb6t1D/dfjsx0kvG/Ny2yF9kiKRTmwsDy5C8x3ONGse8fGWKh2HtJ4gPluA754zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5wXx1fomwPRGhWNiBlZVNG4MTyfJX1vHSR2d0J6JKFo=;
 b=QU1UY3bwjHikX4YFS2tFGGO0aut33fW5MVOJ7M1IQx8bkw8BzVgAuDQYvSB4cycR9VY3FiBBkJm1niIfr3kwuhbPG2lktz0zUkJ1ys73EV6S6Z7vdrXZAXGwGjJxrC+x4oz1D+bu03cPiAUF0YfA6p09Vsg2383Hj+YagODPpQ5e7CZTztdXpSoMhVM9/bFwtkTUQMOT4jvnq/ns2v3882D/SsHWvmPKZBmTG1OIJHdD9YkbrIZ2qG2RlZReT3hm0zfHIubH1M6U4qBmhGimtEc0b+p7TpFOIATMMWFOfjsVE5WLoVA+y39Yg/WFZ+BeM6YtFKMjorF71w7RbI98sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB5325.eurprd04.prod.outlook.com (2603:10a6:803:60::14)
 by VI1PR04MB6173.eurprd04.prod.outlook.com (2603:10a6:803:ff::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.23; Mon, 6 Jul
 2020 12:50:45 +0000
Received: from VI1PR04MB5325.eurprd04.prod.outlook.com
 ([fe80::dcff:4fd4:7403:f1b4]) by VI1PR04MB5325.eurprd04.prod.outlook.com
 ([fe80::dcff:4fd4:7403:f1b4%5]) with mapi id 15.20.3153.029; Mon, 6 Jul 2020
 12:50:44 +0000
Date: Mon, 6 Jul 2020 12:50:36 +0000
From: Luis Chamberlain <mcgrof@suse.com>
To: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 02/17] Documentation/driver-api: firmware/built-in-fw:
 drop doubled word
Message-ID: <20200706125036.llvg2mgmr7a4ydni@ergon.do-not-panic.com>
References: <20200704034502.17199-1-rdunlap@infradead.org>
 <20200704034502.17199-3-rdunlap@infradead.org>
Content-Disposition: inline
In-Reply-To: <20200704034502.17199-3-rdunlap@infradead.org>
X-ClientProxiedBy: BY3PR05CA0028.namprd05.prod.outlook.com
 (2603:10b6:a03:254::33) To VI1PR04MB5325.eurprd04.prod.outlook.com
 (2603:10a6:803:60::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ergon.do-not-panic.com (178.128.74.135) by BY3PR05CA0028.namprd05.prod.outlook.com (2603:10b6:a03:254::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.8 via Frontend Transport; Mon, 6 Jul 2020 12:50:44 +0000
Received: by ergon.do-not-panic.com (Postfix, from userid 1000)	id EC0FEA2856; Mon,  6 Jul 2020 12:50:36 +0000 (UTC)
X-Originating-IP: [178.128.74.135]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 743f4daf-1c58-4b23-fd3d-08d821ab327d
X-MS-TrafficTypeDiagnostic: VI1PR04MB6173:
X-Microsoft-Antispam-PRVS: 
	<VI1PR04MB6173A4766C59D95B10831F90F0690@VI1PR04MB6173.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-Forefront-PRVS: 04569283F9
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	8QKd0IN2aSMYsWoYj52PX5PysF/dW//lGCEbeH0Fi5uGqHDI6tYacudyeB5xMRDbCpnHVPYyAZevMDiwx0zb8lQ1EhKJjoyFBJ/17Ur4sZt3MsE0heFvlA9y2sT9UM5vD0uf+WU3xxOi5IcUtOXpt+1FjX5EC/7xE5jj4o1CSlkBxb3jHh4dgrofUhiT+bNZy4C6X2Y8+ikp9XHHe23U4aRzsuwjgaJn5LS4j1zhSbuPCrMEXFFEcUKtyZ94tlJbY1V8vTIAMqlYlVuqUCJ51/To+dWmHARUDryp43DTyn2vnmUS/gsW4yoUHs/gCJuEAKqdlI6bZPktcUO3TPq5xg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5325.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(39860400002)(376002)(136003)(366004)(346002)(6916009)(9686003)(52116002)(186003)(7416002)(42186006)(316002)(6266002)(4326008)(8936002)(26005)(54906003)(8676002)(478600001)(4744005)(66556008)(66476007)(66946007)(2906002)(1076003)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 
	Mb8GQRRldTCnyvM8Adi7uHnOb037Eld+uNceQL9ruoX6sJ5NLsKMj3JTCl2aKNTIuUCRTMAH1KuH0/buN08WyQUWU+lBv28VgI6mf5uSMtWrNSGeWnXjl/fMoZ7wZM24AxEVJFFKFAF0FN9k3NOyJoITaJ0SQy7GnWIjEA/+GkSWZ8jrkwAHNv05ZQbI8lrKN0HFhg712cSVD1iCGah2UELlj6u6twBmOxuz0vBFhapWZZV7YIP7UOchbc6z671YKHT3cu4gQ7BmmbmyMNlOMcU4mudyCF+wQ5CNXFIToczMgOQF280BZ0xbFVoPfAJJVy8rRTKoOcA/Pi2CorVhtTZV4jhRB7b6d+neiDBDiZZ89ZALZibx+/spVUSfgaYoFG7sLxkzzzX5PYvVk9NkSFonqYb1Tu8Ce+zbzeHj+w3k04XUBGPAs/HyvRpdguixT9WUjGrQZFemEAk7nGLItviw9y0f2uvJBXacylqloNam879Wlq+HJHNJuU2TiZcN
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 743f4daf-1c58-4b23-fd3d-08d821ab327d
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5325.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2020 12:50:44.8174
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZL/MSPQ7vF6G817vDWiCPHaUz/7g1QBwypX6CWbRGwuxqbC0IzBzB/o11VDOQnRsD+XcmWon58h2h0S4bSPOYh9U6QTaSZC0p+rcOYFddDA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6173
Message-ID-Hash: ITXUB6T5XKI5D73R5FIGOWHAIYYPXFBW
X-Message-ID-Hash: ITXUB6T5XKI5D73R5FIGOWHAIYYPXFBW
X-MailFrom: luis.chamberlain@suse.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, William Breathitt Gray <vilhelm.gray@gmail.com>, linux-iio@vger.kernel.org, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, Jon Mason <jdmason@kudzu.us>, Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com, linux-nvdimm@lists.01.org, linux-usb@vger.kernel.org, Eli Billauer <eli.billauer@gmail.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ITXUB6T5XKI5D73R5FIGOWHAIYYPXFBW/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Jul 03, 2020 at 08:44:47PM -0700, Randy Dunlap wrote:
> Drop the doubled word "for".
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

For all the firmware patches you sent:

Acked-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
