Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3253D1A18F
	for <lists+linux-nvdimm@lfdr.de>; Fri, 10 May 2019 18:32:46 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 635B82126CF8A;
	Fri, 10 May 2019 09:32:44 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=148.163.147.86; helo=mx0a-002e3701.pphosted.com;
 envelope-from=elliott@hpe.com; receiver=linux-nvdimm@lists.01.org 
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com
 [148.163.147.86])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 293D521268FAC
 for <linux-nvdimm@lists.01.org>; Fri, 10 May 2019 09:32:41 -0700 (PDT)
Received: from pps.filterd (m0134421.ppops.net [127.0.0.1])
 by mx0b-002e3701.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x4AGKtiK010000; Fri, 10 May 2019 16:32:31 GMT
Received: from g4t3426.houston.hpe.com (g4t3426.houston.hpe.com
 [15.241.140.75])
 by mx0b-002e3701.pphosted.com with ESMTP id 2sdb13gtqj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 May 2019 16:32:31 +0000
Received: from G1W8106.americas.hpqcorp.net (g1w8106.austin.hp.com
 [16.193.72.61])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by g4t3426.houston.hpe.com (Postfix) with ESMTPS id 85BD45C;
 Fri, 10 May 2019 16:32:30 +0000 (UTC)
Received: from G9W9209.americas.hpqcorp.net (16.220.66.156) by
 G1W8106.americas.hpqcorp.net (16.193.72.61) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 10 May 2019 16:32:29 +0000
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (15.241.52.10) by
 G9W9209.americas.hpqcorp.net (16.220.66.156) with Microsoft SMTP
 Server (TLS)
 id 15.0.1367.3 via Frontend Transport; Fri, 10 May 2019 16:32:28 +0000
Received: from AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM (10.169.7.147) by
 AT5PR8401MB0785.NAMPRD84.PROD.OUTLOOK.COM (10.169.7.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.22; Fri, 10 May 2019 16:32:26 +0000
Received: from AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2884:44eb:25bf:b376]) by AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2884:44eb:25bf:b376%12]) with mapi id 15.20.1878.022; Fri, 10 May
 2019 16:32:26 +0000
From: "Elliott, Robert (Servers)" <elliott@hpe.com>
To: Larry Bassel <larry.bassel@oracle.com>, "mike.kravetz@oracle.com"
 <mike.kravetz@oracle.com>, "willy@infradead.org" <willy@infradead.org>,
 "dan.j.williams@intel.com" <dan.j.williams@intel.com>, "linux-mm@kvack.org"
 <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-nvdimm@lists.01.org"
 <linux-nvdimm@lists.01.org>
Subject: RE: [PATCH, RFC 1/2] Add config option to enable FS/DAX PMD sharing
Thread-Topic: [PATCH, RFC 1/2] Add config option to enable FS/DAX PMD sharing
Thread-Index: AQHVBoGeTmkAemjoekib1TYYWlBJqqZkjkrQ
Date: Fri, 10 May 2019 16:32:26 +0000
Message-ID: <AT5PR8401MB116928031D52A318F04A2819AB0C0@AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM>
References: <1557417933-15701-1-git-send-email-larry.bassel@oracle.com>
 <1557417933-15701-2-git-send-email-larry.bassel@oracle.com>
In-Reply-To: <1557417933-15701-2-git-send-email-larry.bassel@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2601:2c3:877f:e23c:eda6:b2df:f285:610b]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f23d3430-588f-45c8-b52f-08d6d56516c2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);
 SRVR:AT5PR8401MB0785; 
x-ms-traffictypediagnostic: AT5PR8401MB0785:
x-microsoft-antispam-prvs: <AT5PR8401MB0785C368E342B5E9436A2BF1AB0C0@AT5PR8401MB0785.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0033AAD26D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(376002)(366004)(39860400002)(136003)(346002)(199004)(189003)(13464003)(74316002)(52536014)(46003)(186003)(110136005)(86362001)(2201001)(229853002)(66446008)(66946007)(55016002)(64756008)(66556008)(66476007)(478600001)(4744005)(5660300002)(6436002)(9686003)(316002)(73956011)(76116006)(14454004)(81166006)(256004)(81156014)(33656002)(25786009)(2501003)(8936002)(446003)(8676002)(99286004)(68736007)(71190400001)(71200400001)(53936002)(6246003)(305945005)(2906002)(102836004)(476003)(11346002)(6116002)(7696005)(76176011)(7736002)(6506007)(53546011)(486006);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AT5PR8401MB0785;
 H:AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: hpe.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: G+l2Qd5ZRkoUmswyYI5tPsZbCdBjUhRZaUOeI0i2AEi6Y+GYPvwtbwcVSZHqdGmqFFoP+JnzYf30hBYwtnWRp7qBsIqUTl/29EdT0gGkqspTEcMLIrUx5dsUfESKDZuJrkLdZBvWMcG2HMIinoZVS4oUrsC83/yzRnCuCFtLmAPzoYFrLCUPhJD32E064t25XAUFX3IeUd0iNncfbY4JaegUvA+VkexB0CGaUG3Up083wTTtvoGhcH7rwoaxBX/6ayYCif1WBt/dTpCPHVkjMRHklmp+5+2tpT9LWQj5vp0Nxj1KcwR2XyW5ItIN1qiYXuFz3jnXXhlyVbFhkP78zrnPwacNQUabjUt1tYg4yPYyj4ACjLANuxlzwANVYGEmXIOv6h5TD+hillrAEWJBO/kGWHnd4uxAv7bc4+Se0mw=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f23d3430-588f-45c8-b52f-08d6d56516c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2019 16:32:26.8565 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AT5PR8401MB0785
X-OriginatorOrg: hpe.com
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-05-09_02:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905100111
X-BeenThere: linux-nvdimm@lists.01.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>



> -----Original Message-----
> From: Linux-nvdimm <linux-nvdimm-bounces@lists.01.org> On Behalf Of
> Larry Bassel
> Sent: Thursday, May 09, 2019 11:06 AM
> Subject: [PATCH, RFC 1/2] Add config option to enable FS/DAX PMD
> sharing
> 
> If enabled, sharing of FS/DAX PMDs will be attempted.
> 
...
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
...
> 
> +config MAY_SHARE_FSDAX_PMD
> +	def_bool y
> +

Is a config option really necessary - is there any reason to
not choose to do this?



_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
