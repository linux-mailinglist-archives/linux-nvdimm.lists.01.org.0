Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E9B320260
	for <lists+linux-nvdimm@lfdr.de>; Sat, 20 Feb 2021 02:12:20 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9DC77100EBB63;
	Fri, 19 Feb 2021 17:12:18 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.151.31.85; helo=userp2120.oracle.com; envelope-from=konrad.wilk@oracle.com; receiver=<UNKNOWN> 
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 15C59100EBBD1
	for <linux-nvdimm@lists.01.org>; Fri, 19 Feb 2021 17:12:16 -0800 (PST)
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
	by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11K1ANrW007775;
	Sat, 20 Feb 2021 01:11:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=EHEbyV2fJCjXgnx9K7KQEMP0S1AALOxTP0tXK1aOGXY=;
 b=a06DyxlmhvKkLM6O1iGShYMeAyjUd95PDGQgHwc61eokXmu/U7sWt05AsKjt6cCkEkiE
 /4eqOyoKB1GXO/HGpGa9qrf5ppWUxx/oZWNHmMs2Iwpp9f2/KoP6yivfbXDAw5laPCnQ
 VKxxAlNZyChMrD14S2EdVU9qLhmJW5HbQFlDAToyjBmhVPJVyIebnhch8P4c7wXVx5uF
 yAU15NJOHQqRyzZOQiyfgwQJPICysxwA+McqGYitGW6s51x+1jj3lXHkkYKPCr2MGjHX
 PggWZpvt6vmqpLlvrZtkAVdOysS+Q1m9eH7VqK1Zn5uko7QxwAlpp3jCW9+TbkqSZ4z4 6w==
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
	by userp2120.oracle.com with ESMTP id 36p7dnu32v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 20 Feb 2021 01:11:22 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
	by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11K1AVCn170644;
	Sat, 20 Feb 2021 01:11:21 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
	by aserp3030.oracle.com with ESMTP id 36trf9835p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 20 Feb 2021 01:11:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bdws0MB1/0Pt73tGLGzGBd/WUUeZ4JWZD7JNMMZK2UFkrwj26YVOQ0FiY8+oSjmUO+hebpUgRTJ5t8wYiTy6RScExsA46cboR4gh5YcaM+9NBrpbD3L0lTPp/mKYKNnNunVHERG9oEe6FQs/DlvEzjv2A1zKK3KuB/CMCTeMdKWTBNo62aoDlJyTpI7iO/Jkogadx+tE79Id2qcu6XUBHlva2aAgqdD4wEOJsht4ih/GSiBSbD77nF8/LEWttQnQHgaoxqK+2nHLAqbuPkeZPlEgIusLhINvD002IyI6YCEEF6nACO+dHZHPtSavQmNSlpS/IfhHiKk5hqiwwDjdSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EHEbyV2fJCjXgnx9K7KQEMP0S1AALOxTP0tXK1aOGXY=;
 b=Uy5PdVAhaugg6bQICoPt4BcuVID+6rdg1FhTRpPiJXJemi60DA2Mgm8vaQevXGlD2MuqMwAj0oAUD1XxPtZW5P7hAej+UX/P1g4cJ2mU5OJvkjSWE+L8pnB/TSMK8dFo0eGqRx2XFWBYMXOgAjymefEGdtCiK7VpZZczRWAVGFjn253XSBWvUOTsA1HPdOILbGDwRnXP98V57L6/EfLGDJwChilAnEWzPilTaSX0MM2yRaSsGqJriX2hSOdrGva1O+R0SWo1ZDvlLlrGDIY4yEMj4aaxjQY+5QHgmh/wz+j7HMf9ZwQjgR2NQ8LVMONLtxZaJwZ7HQqnLI6BAuk7oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EHEbyV2fJCjXgnx9K7KQEMP0S1AALOxTP0tXK1aOGXY=;
 b=p/sUyEMFpJP2HsErbYHfsWZOobORq4z0XYHekyvo0IkTBX96eplkl9i1qdgXxiZnbZPsPVwABEJTkpNh4q9KbLlhvsQeWQSmOed6JT8d4+JlAU3sQJDSDJdMZtIWSPlO/BgP9e7JWcbXHo5I7X6l5Mg7GB+T2iPI7jANNYhfPdI=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB2999.namprd10.prod.outlook.com (2603:10b6:a03:85::27)
 by BYAPR10MB3687.namprd10.prod.outlook.com (2603:10b6:a03:125::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.31; Sat, 20 Feb
 2021 01:11:19 +0000
Received: from BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::e180:1ba2:d87:456]) by BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::e180:1ba2:d87:456%4]) with mapi id 15.20.3846.039; Sat, 20 Feb 2021
 01:11:19 +0000
Date: Fri, 19 Feb 2021 20:11:14 -0500
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Ben Widawsky <ben.widawsky@intel.com>
Subject: Re: [PATCH v5 6/9] cxl/mem: Enable commands via CEL
Message-ID: <YDBhsntkwy249RYn@Konrads-MacBook-Pro.local>
References: <20210217040958.1354670-1-ben.widawsky@intel.com>
 <20210217040958.1354670-7-ben.widawsky@intel.com>
Content-Disposition: inline
In-Reply-To: <20210217040958.1354670-7-ben.widawsky@intel.com>
X-Originating-IP: [209.6.208.110]
X-ClientProxiedBy: SA0PR11CA0163.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::18) To BYAPR10MB2999.namprd10.prod.outlook.com
 (2603:10b6:a03:85::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Konrads-MacBook-Pro.local (209.6.208.110) by SA0PR11CA0163.namprd11.prod.outlook.com (2603:10b6:806:1bb::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend Transport; Sat, 20 Feb 2021 01:11:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fc56d7a7-95fa-41e6-b32d-08d8d53c6e04
X-MS-TrafficTypeDiagnostic: BYAPR10MB3687:
X-Microsoft-Antispam-PRVS: 
	<BYAPR10MB36876665CDA13FF7BCCBE90A89839@BYAPR10MB3687.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	F8pYeTKel57B5fhxrrMbnLvecEB0K9E6SaUFUHehDMFpTsxyvSjttatPeBzNtnJftXw7LQvRVFEv2BjUpWo7iyb6ULfqSP6lFFKDcSKFdV0Wyt7NJhLQuu6fW5tV9VyQsK6RlHBp+jWuTu+Q3iH90en+XxiGzq/ipSaG/me6Ya+6asp6QKeg0vm+KeU5dUD9cTdxwJ5ERetpA0K7ZDBI0q73rZXELa2LOaexZ9lPRRAcgqwSQuNpxcYRIcgw+lcH2IsEd17EAlEF4KCwCGarq2Qp3aLmrXTYbpU3ojgE1a9A40IVqAmoAPbTB50ae1+SjSq2duJRMQAmrGI5HNAsLTDLZpI9pJgxx/pdMqrBgAzhPV8UFp0mrn1hzJn7KOHZIAuU30Q8xTggFQYYkz6y9R+X1pPI4vk7bIP0TT5PzF3fWeG9vs05ZNdnYh/k6Z2sN7dZYnJ3Iu+GqpNab1E9Z0AJkOjgWB5UOYQqL7y5F33jTrY+sYN5B2hve02C2Vg9qBxlOx6o8zdSa35ByRDETg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2999.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(396003)(366004)(376002)(346002)(54906003)(66946007)(478600001)(5660300002)(66476007)(55016002)(4326008)(4744005)(66556008)(7416002)(956004)(86362001)(7696005)(6506007)(26005)(2906002)(9686003)(316002)(8676002)(186003)(6666004)(16526019)(52116002)(6916009)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 
	=?us-ascii?Q?g568jt9AhGBZewf8RylOzJWZ43K2ePxHODBJ2/NNotmLmXnoDuQtP0LMNl5C?=
 =?us-ascii?Q?eKQWvK5Af1ypp7Lv2sLpt+WLicmifl1NxvgYvPGylJj+X/GFpG1vLI+vEvjs?=
 =?us-ascii?Q?mSOUFV7oEW8sNANS+VZ7YZAkV7OGqjeq750CbFvX26+BZzFtghUKms/0yQXr?=
 =?us-ascii?Q?IAgR4/xiNHl9blvtQHnsxA/0icFg9w5zWD2CumRKit99Mo3Y2INcn7P14Wqs?=
 =?us-ascii?Q?zYp7bD+6jhXAH4NzNHD8vffaSp7Ty3CKaThgjmxeYsFpAubxUrMj3xLgnh2J?=
 =?us-ascii?Q?wcP9JLHjrQvue6Q+7F8Cz2AVWHEPRnjVzE38LYCny2UAWd2poTVfbCV9OGJa?=
 =?us-ascii?Q?gOinsGGuM5yTMRSlItIZfMJtaL8+677KPBCWXc0ADfoXUiJIqztms2QS0S6R?=
 =?us-ascii?Q?WTKWAu9SPejCiioIcb4UM8bJfDcPnD4LlcKTdLsUqmw9ikwEspIn30cRjx+q?=
 =?us-ascii?Q?RYPePgOqn8IPF3USKI0BOddSnBJkvSIVj1Oh53q8qmLQCcpu4inUgYAZ31KU?=
 =?us-ascii?Q?UjnTCNQXgdJb+kJUwdziB1a5FzD4XbBpKMIxef6/ClKaSNFSj/b7bK1M1ROT?=
 =?us-ascii?Q?FcUTOK2vYMCKo8fOu5uyO6ocWaJjFamxl2BaBq5iMHc6di8z5de7gW419RZs?=
 =?us-ascii?Q?iZT/qo4H5r30WlqpMrEDueaPpevxDnTBZ7GP7Sj3ED3fLtaPddOELTs9UFp1?=
 =?us-ascii?Q?n8UaTbUMPuh0sJooj2GhM8dMWqxybeXm7F9Rg7uB8m78PyressikQ9D8oWcL?=
 =?us-ascii?Q?ABwjwxjePiYnSn/ZiOQbxWCE5BT207MHFpSt8TLDqku+rig0dXqCV7ykvLjE?=
 =?us-ascii?Q?uZx70mdFQiBDAu0Dg/aOMCtZQJr0VVga4ogEHFg6rv1bRve8wGAi0M+WtCWe?=
 =?us-ascii?Q?8CqPsvldkQIsdbVZhFs7EbyrElbTmrjsyXad0ARZ3teE9M0gn9fshZvy2ict?=
 =?us-ascii?Q?tuozxm2bX7TmCJ6lrADELfZPkk5l7FIRUqKo8tLMRKFL82JlHB3RH9J+tDVe?=
 =?us-ascii?Q?i4BTuwOiuw7wZTZOKLvoP8znWNgLBpEG9RWgu7QhwtNC7je7z2yOpTVKw429?=
 =?us-ascii?Q?0V3wqxfCpUvGJF8lnZAv4+7TJPioOywFaT23uxoyto9Irs6bzcxRnTavyO/Z?=
 =?us-ascii?Q?CNU82Z8aC/bocWH1xs8MlkVqotLWCA+DK7EylDLjP7nE9wZgRuJQdnaX6Hrb?=
 =?us-ascii?Q?QvuBeEtQPTJMrJFrJ1/oRbjK6hnVacQF5yxRFjapW/L+csFEZOJHxoiQYNlx?=
 =?us-ascii?Q?uQexD2luL+pPp/EHgRaogVig1xaJisZHg1q8yh4BiuYnwQykPecNTxVKyVhG?=
 =?us-ascii?Q?fz9V1GonRE1O2RLdrYlgw1nm?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc56d7a7-95fa-41e6-b32d-08d8d53c6e04
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2999.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2021 01:11:19.5040
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GCsod83ZHd5AKIAS0Fx7FLwsGcCmsB4cDJJFYHbMdDQSY/iKrnfs+hpZdTlKWgeTCcMigzLSxEJPJYruVvIr2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3687
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9900 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102200005
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9900 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 spamscore=0 adultscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102200005
Message-ID-Hash: 7BLNW2HQ7U73F54KLYQCXR4Z35IWPQAA
X-Message-ID-Hash: 7BLNW2HQ7U73F54KLYQCXR4Z35IWPQAA
X-MailFrom: konrad.wilk@oracle.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>, Chris Browy <cbrowy@avery-design.com>, Christoph Hellwig <hch@infradead.org>, David Hildenbrand <david@redhat.com>, David Rientjes <rientjes@google.com>, Jon Masters <jcm@jonmasters.org>, Jonathan Cameron <Jonathan.Cameron@Huawei.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Randy Dunlap <rdunlap@infradead.org>, "John Groves (jgroves)" <jgroves@micron.com>, "Kelley, Sean V" <sean.v.kelley@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/7BLNW2HQ7U73F54KLYQCXR4Z35IWPQAA/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> +static inline struct cxl_mem_command *cxl_mem_find_command(u16 opcode)
> +{
> +	struct cxl_mem_command *c;
> +
> +	cxl_for_each_cmd(c)

Would you be amenable to adding {
> +		if (c->opcode == opcode)
> +			return c;
> +
and } here

(and in the code below as well where cxl_for_each_cmd is used?)

Regardless of that:

Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
