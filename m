Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE584252B0
	for <lists+linux-nvdimm@lfdr.de>; Tue, 21 May 2019 16:49:57 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id ECF532127545D;
	Tue, 21 May 2019 07:49:55 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=148.163.147.86; helo=mx0a-002e3701.pphosted.com;
 envelope-from=elliott@hpe.com; receiver=linux-nvdimm@lists.01.org 
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com
 [148.163.147.86])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 7F33721275442
 for <linux-nvdimm@lists.01.org>; Tue, 21 May 2019 07:49:53 -0700 (PDT)
Received: from pps.filterd (m0134422.ppops.net [127.0.0.1])
 by mx0b-002e3701.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x4LEehgS008034; Tue, 21 May 2019 14:49:51 GMT
Received: from g2t2352.austin.hpe.com (g2t2352.austin.hpe.com [15.233.44.25])
 by mx0b-002e3701.pphosted.com with ESMTP id 2smjsyge3y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 May 2019 14:49:51 +0000
Received: from G2W6311.americas.hpqcorp.net (g2w6311.austin.hp.com
 [16.197.64.53])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by g2t2352.austin.hpe.com (Postfix) with ESMTPS id 444C5CA;
 Tue, 21 May 2019 14:49:50 +0000 (UTC)
Received: from G9W8672.americas.hpqcorp.net (16.220.49.31) by
 G2W6311.americas.hpqcorp.net (16.197.64.53) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 21 May 2019 14:49:49 +0000
Received: from G9W9210.americas.hpqcorp.net (2002:10dc:429b::10dc:429b) by
 G9W8672.americas.hpqcorp.net (2002:10dc:311f::10dc:311f) with Microsoft SMTP
 Server (TLS) id 15.0.1367.3; Tue, 21 May 2019 14:49:49 +0000
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (15.241.52.12) by
 G9W9210.americas.hpqcorp.net (16.220.66.155) with Microsoft SMTP
 Server (TLS)
 id 15.0.1367.3 via Frontend Transport; Tue, 21 May 2019 14:49:49 +0000
Received: from AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM (10.169.7.147) by
 AT5PR8401MB0692.NAMPRD84.PROD.OUTLOOK.COM (10.169.7.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.15; Tue, 21 May 2019 14:49:47 +0000
Received: from AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2884:44eb:25bf:b376]) by AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2884:44eb:25bf:b376%12]) with mapi id 15.20.1922.016; Tue, 21 May
 2019 14:49:47 +0000
From: "Elliott, Robert (Servers)" <elliott@hpe.com>
To: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>, Dan Williams
 <dan.j.williams@intel.com>
Subject: RE: [PATCH] mm/nvdimm: Use correct #defines instead of opencoding
Thread-Topic: [PATCH] mm/nvdimm: Use correct #defines instead of opencoding
Thread-Index: AQHVCgChFb7/EbTm2EmzJ0DwQTd3laZp/p0AgAAB4ICAAAH7AIAACYkAgAsy44CAACJ3AIAAUp6Q
Date: Tue, 21 May 2019 14:49:47 +0000
Message-ID: <AT5PR8401MB1169DEEAA95D4E4EA9C61285AB070@AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM>
References: <20190514025604.9997-1-aneesh.kumar@linux.ibm.com>
 <CAPcyv4iNgFbSq0Hqb+CStRhGWMHfXx7tL3vrDaQ95DcBBY8QCQ@mail.gmail.com>
 <f99c4f11-a43d-c2d3-ab4f-b7072d090351@linux.ibm.com>
 <CAPcyv4gOr8SFbdtBbWhMOU-wdYuMCQ4Jn2SznGRsv6Vku97Xnw@mail.gmail.com>
 <02d1d14d-650b-da38-0828-1af330f594d5@linux.ibm.com>
 <CAPcyv4jcSgg0wxY9FAM4ke9JzVc9Pu3qe6dviS3seNgHfG2oNw@mail.gmail.com>
 <87mujgcf0h.fsf@linux.ibm.com>
In-Reply-To: <87mujgcf0h.fsf@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2601:2c3:877f:e23c:fdc1:1746:34b1:a6c]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8bde30a5-0cc3-4142-e927-08d6ddfb920f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);
 SRVR:AT5PR8401MB0692; 
x-ms-traffictypediagnostic: AT5PR8401MB0692:
x-microsoft-antispam-prvs: <AT5PR8401MB06927E80F27B0859F1AB8DD6AB070@AT5PR8401MB0692.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:1148;
x-forefront-prvs: 0044C17179
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(136003)(346002)(376002)(366004)(39860400002)(199004)(13464003)(189003)(7736002)(6246003)(9686003)(6116002)(54906003)(2906002)(8676002)(110136005)(53936002)(99286004)(316002)(33656002)(476003)(305945005)(4326008)(7696005)(71200400001)(81166006)(76176011)(71190400001)(81156014)(68736007)(8936002)(6506007)(25786009)(102836004)(6436002)(53546011)(229853002)(55016002)(256004)(74316002)(66556008)(64756008)(52536014)(66446008)(5660300002)(66476007)(4744005)(186003)(46003)(486006)(76116006)(73956011)(66946007)(478600001)(86362001)(14454004)(446003)(11346002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AT5PR8401MB0692;
 H:AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: hpe.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: I6AvVHDPGKk7QMDyM6WBco+hI7j4gcsJhjY/RP65hwAnce/6EqoPnFr7NycudNWW9ykAfbvGBsXqofG9GOEdKXuVxkoghOugxPy3ZmPs5XmWsFNH7/nwWq/0P2CHf8xZIF6O1hM3qoOND1KbBukFQS0Jzsnga2R2c9sH0HvnWvjhsGh05GHPHbbWAety5ebD9Xi8jEgDd92n9XwaCsfvZ0OLzkVrA0qnk5HC5Vuq7M3iGWs8aU+8SIks3fqvKF5q+1jhyh3xExrwC1bYJK0HBcMkTqxOvXjfb020DqdHivYUcH/4t+FPx3qZME+wQa8ldQL3PLfJ2sjTToks2adNkqS2Zh+H6BNFmssdOAtDAY9TiTW5L++2MZo2liV1FRVPqLhFrT3BeLpjTFOGyJdqn5mjKy32ZsYQ9ijVLw74JM0=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bde30a5-0cc3-4142-e927-08d6ddfb920f
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2019 14:49:47.4838 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: elliott@hpe.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AT5PR8401MB0692
X-OriginatorOrg: hpe.com
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-05-21_03:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=855 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905210092
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
Cc: Linux MM <linux-mm@kvack.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>



> -----Original Message-----
> From: Linux-nvdimm <linux-nvdimm-bounces@lists.01.org> On Behalf Of
> Aneesh Kumar K.V
> Sent: Tuesday, May 21, 2019 4:51 AM
> Subject: Re: [PATCH] mm/nvdimm: Use correct #defines instead of
> opencoding
> 
...
> @@ -36,6 +36,9 @@ struct nd_pfn_sb {
>  	__le32 end_trunc;
>  	/* minor-version-2 record the base alignment of the mapping */
>  	__le32 align;
> +	/* minor-version-3 record the page size and struct page size
> */
> +	__le32 page_size;
> +	__le32 page_struct_size;
>  	u8 padding[4000];
>  	__le64 checksum;
>  };

You might need to reduce the padding size to offset the extra added
fields.


_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
