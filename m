Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A755E5626
	for <lists+linux-nvdimm@lfdr.de>; Fri, 25 Oct 2019 23:52:30 +0200 (CEST)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B04F2100EEBBA;
	Fri, 25 Oct 2019 14:53:38 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=40.107.130.135; helo=apc01-hk2-obe.outbound.protection.outlook.com; envelope-from=decui@microsoft.com; receiver=<UNKNOWN> 
Received: from APC01-HK2-obe.outbound.protection.outlook.com (mail-eopbgr1300135.outbound.protection.outlook.com [40.107.130.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id EDDBB100EEBB6
	for <linux-nvdimm@lists.01.org>; Fri, 25 Oct 2019 14:53:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nR+lVvnZeD6OPFeOOr6oOJjCgD07rFzmDK/TmVfjC4xtX9Fdf6nnu41uchMiuYMawKWQjxOa5bXD1GH/gcuBAV3rLdGrWQxhk0sS/0LiAva1eNQkLxfhLffkU8HdHTrNqPJ3q7X8TXfSfBmrxzj+PdPoV+FDid4z3YQ16H/belm58XJj6gutrizQbtKZI57ZdSHf9lsiehdvBtjBm/stYUsnWGQOMgI23YuhAXErfV4BGplSg7LUpZo4SqJE+mhpKRpXnT4oSMq1ZKRcKL/bh/qz8RXJ5l5oknX0FDMqLLGOQZcgLdUe/3fhNz02NwVTgfChDfwHa5Twikc+xNtlHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a2YkTlNHjrUM0tNcfPKiDRKZEqFrkHlJG4nbc+ydIjY=;
 b=EdjQEAW1vJKTJkQ3fgr3govBJpOOxDvoWSeoiRe/t4ESrDiB+pMwOXdXsCIhgy2OpbIexq+leC37rIqJKQRt2jQ12yE+zD+YsJIPYpHxDlWq2vBK2ghCRTVRK137nMatQ0l7MDcquv1E2pwmdgysxxUtfrpCYhXSfLaQw/iNzvCaKS4c/1GlPALpgxwX2rL8ywcTfJX0x8m6E8uNEwz5AJBEXovz6onkvCl4K7FExDwWWH2D258SLSc20ZSsTVnyQPD13BrA3ePjL/+QJTL+92O67EeNA62UkLiqRdmnVzkjwpIh6Z2O7kv1b39ifjSGInw/cd7GukeQps18LufLhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a2YkTlNHjrUM0tNcfPKiDRKZEqFrkHlJG4nbc+ydIjY=;
 b=Nqz1vrOfzHlwdyg+QSWH2RdMBZ2kINgvUm2pt9au01P7KFfF/LWOCSUuvh+JlaOkzQL6TX57ucvcLQ2RjD3WAW/0HyUHZBhWMHrkGLt4Zoecy2cRmYnHOxPkOk064dcub6TE8C2ERVyPud7czNH6z65tgcCBP5D7mgxyvgWnRjw=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0123.APCP153.PROD.OUTLOOK.COM (10.170.188.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.9; Fri, 25 Oct 2019 21:52:16 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::69f1:c9:209a:1809]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::69f1:c9:209a:1809%2]) with mapi id 15.20.2408.008; Fri, 25 Oct 2019
 21:52:16 +0000
From: Dexuan Cui <decui@microsoft.com>
To: D Scott Phillips <d.scott.phillips@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, David Howells <dhowells@redhat.com>, Jerry
 Hoemann <jerry.hoemann@hpe.com>, stuart hayes <stuart.w.hayes@gmail.com>,
	Toshi Kani <toshi.kani@hpe.com>, Vishal Verma <vishal.l.verma@intel.com>,
	"linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Subject: RE: [PATCH] uapi: Add the BSD-2-Clause license to ndctl.h
Thread-Topic: [PATCH] uapi: Add the BSD-2-Clause license to ndctl.h
Thread-Index: AQHVi112Ij26P7t3F0qnvWOXEr+vYKdr5XIg
Date: Fri, 25 Oct 2019 21:52:16 +0000
Message-ID: 
 <PU1P153MB0169DBCFF86599EEE2938A22BF650@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <20191025175553.63271-1-d.scott.phillips@intel.com>
In-Reply-To: <20191025175553.63271-1-d.scott.phillips@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-10-25T21:52:14.8429239Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=622db8f2-e53b-4511-bcd8-c76260883bbb;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com;
x-originating-ip: [2601:600:a280:7f70:f5b6:b399:241c:9e4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c6810aa6-489a-42e5-9833-08d759959a36
x-ms-traffictypediagnostic: PU1P153MB0123:
x-microsoft-antispam-prvs: 
 <PU1P153MB0123C44927B7E9346C8E287DBF650@PU1P153MB0123.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 02015246A9
x-forefront-antispam-report: 
 SFV:NSPM;SFS:(10019020)(4636009)(366004)(136003)(376002)(39860400002)(396003)(346002)(189003)(199004)(86362001)(25786009)(6246003)(7736002)(305945005)(476003)(81156014)(229853002)(8676002)(4326008)(14454004)(71200400001)(81166006)(110136005)(74316002)(71190400001)(33656002)(2906002)(6116002)(5660300002)(102836004)(66446008)(64756008)(66556008)(66476007)(66946007)(8936002)(76116006)(52536014)(478600001)(55016002)(10090500001)(256004)(53546011)(186003)(46003)(9686003)(76176011)(2501003)(6436002)(22452003)(446003)(316002)(486006)(11346002)(10290500003)(7696005)(6506007)(8990500004)(99286004);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0123;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 0lKhZRkAZbn9NYl6KdG30bx7Al3/3yi91qhV+Ztr1nSbkSCrPs/P+JeZzUcHn5rjkwa4iNN5/a3vetTaOANr2PAJ7XAckER8FnHIb/nTRL12RXLCxWz6SaDJnmn+rvCZ6V3WQgT82Uvn2HPgifvkA+lT1zTmA5p2QdkRiVdel+43C5oANOJXCSQtBZJ3WigjSqoRP+iHDCPC3P1EcWg1bE+3GF3qGG5MvULfVqOoSaxn6FFHnUZeFf7rJ06vA81+Pvpfcakwccv1E/MaTKKd458QKC5OOiWu+K7Gj9tDjlRD7ovubQqyrLTP6H9CKABgNC1abL1/gkF5r5Gc4+p/eLxJqLp/LSZ7tfWYPXReW1qNq42lI9WzZq655v+L312yn4cCHmcc1j2gourP+rvxBxaAG/XVK8j+tCO8sITawtxkPty8FItheIGcz5hQIeb4
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6810aa6-489a-42e5-9833-08d759959a36
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2019 21:52:16.4784
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lDlhOMl5xFad251j6s76NLzV72Mc+iipcDriGoiuNCTJAVzHaE8I00bfcN0oO8QntzBRRofwIF3fHRGy8S93bQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0123
Message-ID-Hash: DF7TTBLNRYCGSSYBBJRBHTXN7VM6OZ4A
X-Message-ID-Hash: DF7TTBLNRYCGSSYBBJRBHTXN7VM6OZ4A
X-MailFrom: decui@microsoft.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/5WBUNK6G5ZRBA4DBFUEYME76RJKSDLDE/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Transfer-Encoding: 7bit

> From: D Scott Phillips <d.scott.phillips@intel.com>
> Sent: Friday, October 25, 2019 10:56 AM
> To: Dan Williams <dan.j.williams@intel.com>; David Howells
> <dhowells@redhat.com>; Dexuan Cui <decui@microsoft.com>; Jerry
> Hoemann <jerry.hoemann@hpe.com>; stuart hayes
> <stuart.w.hayes@gmail.com>; Toshi Kani <toshi.kani@hpe.com>; Vishal Verma
> <vishal.l.verma@intel.com>; linux-nvdimm@lists.01.org
> Cc: linux-kernel@vger.kernel.org
> Subject: [PATCH] uapi: Add the BSD-2-Clause license to ndctl.h
> 
> Allow ndctl.h to be licensed with BSD-2-Clause so that other
> operating systems can provide the same user level interface.
> ---
> 
> I've been working on nvdimm support in FreeBSD and would like to
> offer the same ndctl API there to ease porting of application
> code. Here I'm proposing to add the BSD-2-Clause license to this
> header file, so that it can later be copied into FreeBSD.
> 
> I believe that all the authors of changes to this file (in the To:
> list) would need to agree to this change before it could be
> accepted, so any signed-off-by is intentionally ommited for now.
> Thanks,
> 
> Scott

Hi Scott,
I agree to make the change if Dan and Vishal also agree. :-)

Thanks,
-- Dexuan
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
