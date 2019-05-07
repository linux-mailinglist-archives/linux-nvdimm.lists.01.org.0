Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 739E716AED
	for <lists+linux-nvdimm@lfdr.de>; Tue,  7 May 2019 21:13:49 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A34D421243BDF;
	Tue,  7 May 2019 12:13:47 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=40.107.80.124; helo=nam03-dm3-obe.outbound.protection.outlook.com;
 envelope-from=tim.bird@sony.com; receiver=linux-nvdimm@lists.01.org 
Received: from NAM03-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr800124.outbound.protection.outlook.com [40.107.80.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id D73FC21237ADF
 for <linux-nvdimm@lists.01.org>; Tue,  7 May 2019 12:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Sony.onmicrosoft.com; 
 s=selector1-Sony-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OETcERvdxEccn4uxMv/L2c7hJBriL+YRSBY062rstiU=;
 b=OWMlIy5Bfxy8+2fxU1Hi/v6r8c1ChBdI3sL4uPdCZDUiMyG5nyH3FyfJJuioEWDWvT/fcJNrS+d4jwtNXNMmWKu2CBmk1Qw0vb4DD/BCtoe0MbtfFItEdR/w3H/yNKnPF34SlEVDFdIEtwQ8o300lpGgCQ0TbsqDoJo4dPtwPTk=
Received: from MWHPR13CA0016.namprd13.prod.outlook.com (2603:10b6:300:16::26)
 by DM5PR13MB1401.namprd13.prod.outlook.com (2603:10b6:3:11c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1878.15; Tue, 7 May
 2019 19:13:35 +0000
Received: from BL2NAM02FT048.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::206) by MWHPR13CA0016.outlook.office365.com
 (2603:10b6:300:16::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1878.18 via Frontend
 Transport; Tue, 7 May 2019 19:13:34 +0000
Authentication-Results: spf=permerror (sender IP is 160.33.194.229)
 smtp.mailfrom=sony.com; google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=sony.com;
Received-SPF: PermError (protection.outlook.com: domain of sony.com used an
 invalid SPF mechanism)
Received: from usculsndmail02v.am.sony.com (160.33.194.229) by
 BL2NAM02FT048.mail.protection.outlook.com (10.152.76.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1856.11 via Frontend Transport; Tue, 7 May 2019 19:13:34 +0000
Received: from usculsndmail12v.am.sony.com (usculsndmail12v.am.sony.com
 [146.215.230.103])
 by usculsndmail02v.am.sony.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
 ESMTP id x47JDWsZ024534; Tue, 7 May 2019 19:13:32 GMT
Received: from USCULXHUB01V.am.sony.com (usculxhub01v.am.sony.com
 [146.215.231.15])
 by usculsndmail12v.am.sony.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
 ESMTP id x47JDU9f012737; Tue, 7 May 2019 19:13:30 GMT
Received: from USCULXMSG01.am.sony.com ([fe80::b09d:6cb6:665e:d1b5]) by
 USCULXHUB01V.am.sony.com ([146.215.231.15]) with mapi id 14.03.0439.000; Tue,
 7 May 2019 15:13:30 -0400
From: <Tim.Bird@sony.com>
To: <brendanhiggins@google.com>, <frowand.list@gmail.com>
Subject: RE: [PATCH v2 12/17] kunit: tool: add Python wrappers for running
 KUnit tests
Thread-Topic: [PATCH v2 12/17] kunit: tool: add Python wrappers for running
 KUnit tests
Thread-Index: AQHVAHJhoNqUCvrlqkWNVYoBnpR0L6ZX7y8AgAB264CAADSlgIAAKamAgAAhmQCAAEBZgIAA4H+AgABHUoCAAzbVgIABZW4AgAEcg3A=
Date: Tue, 7 May 2019 19:13:14 +0000
Message-ID: <ECADFF3FD767C149AD96A924E7EA6EAF9770AE37@USCULXMSG01.am.sony.com>
References: <20190501230126.229218-1-brendanhiggins@google.com>
 <20190501230126.229218-13-brendanhiggins@google.com>
 <20190502110220.GD12416@kroah.com>
 <CAFd5g47t=EdLKFCT=CnPkrM2z0nDVo24Gz4j0VxFOJbARP37Lg@mail.gmail.com>
 <a49c5088-a821-210c-66de-f422536f5b01@gmail.com>
 <CAFd5g44iWRchQKdJYtjRtPY6e-6e0eXpKXXsx5Ooi6sWE474KA@mail.gmail.com>
 <1a5f3c44-9fa9-d423-66bf-45255a90c468@gmail.com>
 <CAFd5g45RYm+zfdJXnyp2KZZH5ojfOzy++aq+4zBeE5VDu6WgEw@mail.gmail.com>
 <052fa196-4ea9-8384-79b7-fe6bacc0ee82@gmail.com>
 <CAFd5g47aY-CL+d7DfiyTidY4aAVY+eg1TM1UJ4nYqKSfHOi-0w@mail.gmail.com>
 <63f63c7c-6185-5e64-b338-6a5e7fb9e27c@gmail.com>
 <CAFd5g46=ZU58uJ=Qhs3soBzJjzJKJFY0_uzZ7fe1CxPfJioNOA@mail.gmail.com>
In-Reply-To: <CAFd5g46=ZU58uJ=Qhs3soBzJjzJKJFY0_uzZ7fe1CxPfJioNOA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [146.215.228.6]
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:160.33.194.229; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10019020)(1496009)(136003)(396003)(39860400002)(376002)(346002)(2980300002)(448002)(51444003)(189003)(199004)(13464003)(55674003)(126002)(356004)(336012)(50466002)(7736002)(37786003)(246002)(6666004)(305945005)(55846006)(486006)(186003)(316002)(426003)(72206003)(8676002)(436003)(54906003)(33656002)(966005)(229853002)(476003)(2876002)(4326008)(14444005)(446003)(11346002)(110136005)(6246003)(3846002)(102836004)(6116002)(86152003)(55016002)(6306002)(2906002)(5660300002)(53546011)(7406005)(85326001)(7416002)(23676004)(7696005)(26005)(8936002)(47776003)(478600001)(76176011)(70586007)(86362001)(70206006)(66066001)(2486003)(5001870100001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DM5PR13MB1401; H:usculsndmail02v.am.sony.com;
 FPR:; SPF:PermError; LANG:en; PTR:mail.sonyusa.com,mail02.sonyusa.com; MX:1;
 A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4a588ed9-b19c-4f12-e016-08d6d32019ba
X-Microsoft-Antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);
 SRVR:DM5PR13MB1401; 
X-MS-TrafficTypeDiagnostic: DM5PR13MB1401:
X-MS-Exchange-PUrlCount: 3
X-Microsoft-Antispam-PRVS: <DM5PR13MB14015E8F3E30EFCCFDD970A9FD310@DM5PR13MB1401.namprd13.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0030839EEE
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: vSzy8IZrS9bO85wOMSB0Lev7xvGIqUpuDKE1CToyQILnnoycswVpzKBL+9JssNF6pU9sOEJlcJMYQlEJ1ahZ5bwkGP/IRwVh+Jm60ql/CM0DfwovFcS3RPkV/6pRAZxXjMY0ktCgXxHIIcdNiytKWO5IkyZT7ABXlVS6fU+pqovKZ1GUMgk6KZZPwaY9pUQr7JYVM1aazjZAGhBlssA0JCtkC3Rk64yqRSsqMDck2jn5wc7ulTeCcVyuZBq+HQ2laU6Pu4NymV+1bqCAzWhK2WjeRA5QOsAXA6HNMpQKFX/bEVU1xu+9X//I3FwP9lay+aVgvzAgCWuZrd9rcYOZPcJ56Cx9B0kegb4u6jej498ZFMsJuhjA5FY+rySc5ahZXcox3HnMajbxI5Rz5/XuIziYMHsnGbSLmHA5Et+drBE=
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2019 19:13:34.2144 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a588ed9-b19c-4f12-e016-08d6d32019ba
X-MS-Exchange-CrossTenant-Id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=66c65d8a-9158-4521-a2d8-664963db48e4; Ip=[160.33.194.229];
 Helo=[usculsndmail02v.am.sony.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB1401
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
Cc: pmladek@suse.com, linux-doc@vger.kernel.org, amir73il@gmail.com,
 dri-devel@lists.freedesktop.org, Alexander.Levin@microsoft.com,
 mpe@ellerman.id.au, linux-kselftest@vger.kernel.org, shuah@kernel.org,
 robh@kernel.org, linux-nvdimm@lists.01.org, khilman@baylibre.com,
 knut.omang@oracle.com, kieran.bingham@ideasonboard.com,
 felixguoxiuping@gmail.com, wfg@linux.intel.com, joel@jms.id.au,
 rientjes@google.com, dan.carpenter@oracle.com, devicetree@vger.kernel.org,
 linux-kbuild@vger.kernel.org, jdike@addtoit.com, linux-um@lists.infradead.org,
 rostedt@goodmis.org, julia.lawall@lip6.fr, kunit-dev@googlegroups.com,
 richard@nod.at, sboyd@kernel.org, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, mcgrof@kernel.org, daniel@ffwll.ch,
 keescook@google.com, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

Here is a bit of inline commentary on the TAP13/TAP14 discussion.

> -----Original Message-----
> From: Brendan Higgins 
> 
> > On 5/3/19 4:14 PM, Brendan Higgins wrote:
> > >> On 5/2/19 10:36 PM, Brendan Higgins wrote:
> > > In any case, it sounds like you and Greg are in agreement on the core
> > > libraries generating the output in TAP13, so I won't argue that point
> > > further.
> > >
> > > ## Analysis of using TAP13
> >
> > I have never looked at TAP version 13 in any depth at all, so do not consider
> > me to be any sort of expert.
> >
> > My entire TAP knowledge is based on:
> >
> >   https://testanything.org/tap-version-13-specification.html
> >
> > and the pull request to create the TAP version 14 specification:
> >
> >    https://github.com/TestAnything/testanything.github.io/pull/36/files
> >
> > You can see the full version 14 document in the submitter's repo:
> >
> >   $ git clone https://github.com/isaacs/testanything.github.io.git
> >   $ cd testanything.github.io
> >   $ git checkout tap14
> >   $ ls tap-version-14-specification.md
> >
> > My understanding is the the version 14 specification is not trying to
> > add new features, but instead capture what is already implemented in
> > the wild.
> >
> >
> > > One of my earlier concerns was that TAP13 is a bit over constrained
> > > for what I would like to output from the KUnit core. It only allows
> > > data to be output as either:
> > >  - test number
> > >  - ok/not ok with single line description
> > >  - directive
> > >  - diagnostics
> > >  - YAML block
> > >
> > > The test number must become before a set of ok/not ok lines, and does
> > > not contain any additional information. One annoying thing about this
> > > is it doesn't provide any kind of nesting or grouping.
> >
> > Greg's response mentions ktest (?) already does nesting.
> 
> I think we are talking about kselftest.
> 
> > Version 14 allows nesting through subtests.  I have not looked at what
> > ktest does, so I do not know if it uses subtest, or something else.
> 
> Oh nice! That is new in version 14. I can use that.

We have run into the problem of subtests (or nested tests, both using
TAP13) in Fuego.  I recall that this issue came up in kselftest, and I believe
we discussed a solution, but I don't recall what it was.

Can someone remind me what kselftest does to handle nested tests
(in terms of TAP13 output)?

> 
> > > There is one ok/not ok line per test and it may have a short
> > > description of the test immediately after 'ok' or 'not ok'; this is
> > > problematic because it wants the first thing you say about a test to
> > > be after you know whether it passes or not.
> >
> > I think you could output a diagnostic line that says a test is starting.
> > This is important to me because printk() errors and warnings that are
> > related to a test can be output by a subsystem other than the subsystem
> > that I am testing.  If there is no marker at the start of the test
> > then there is no way to attribute the printk()s to the test.
> 
> I agree.

This is a significant problem.  In Fuego we output each line with a test id prefix,
which goes against the spec, but helps solve this.  Test output should be
kept separate from system output, but if I understand correctly, there are no
channels in prinkt to use to keep different data streams separate.

How does kselftest deal with this now?

> 
> Technically conforms with the spec, and kselftest does that, but is
> also not part of the spec. Well, it *is* specified if you use
> subtests. I think the right approach is to make each
> "kunit_module/test suite" a test, and all the test cases will be
> subtests.
> 
> > > Directives are just a way to specify skipped tests and TODOs.
> > >
> > > Diagnostics seem useful, it looks like you can put whatever
> > > information in them and print them out at anytime. It looks like a lot
> > > of kselftests emit a lot of data this way.
> > >
> > > The YAML block seems to be the way that they prefer users to emit data
> > > beyond number of tests run and whether a test passed or failed. I
> > > could express most things I want to express in terms of YAML, but it
> > > is not the nicest format for displaying a lot of data like
> > > expectations, missed function calls, and other things which have a
> > > natural concise representation. Nevertheless, YAML readability is
> > > mostly a problem who won't be using the wrapper scripts.
> >
> > The examples in specification V13 and V14 look very simple and very
> > readable to me.  (And I am not a fan of YAML.)
> >
> >
> > > My biggest
> > > problem with the YAML block is that you can only have one, and TAP
> > > specifies that it must come after the corresponding ok/not ok line,
> > > which again has the issue that you have to hold on to a lot of
> > > diagnostic data longer than you ideally would. Another downside is
> > > that I now have to write a YAML serializer for the kernel.
> >
> > If a test generates diagnostic data, then I would expect that to be
> > the direct result of a test failure.  So the test can output the
> > "not ok" line, then immediately output the YAML block.  I do not
> > see a need for stashing YAML output ahead of time.
> >
> > If diagnostic data is generated before the test can determine
> > success or failure, then it can be output as diagnostic data
> > instead of stashing it for later.
> 
> Cool, that's what I am thinking I am going to do - I just wanted to
> make sure people were okay with this approach. I mean, I think that is
> what kselftest does.

IMHO the diagnostic data does not have to be in YAML.  That's only
if there's a well-known schema for the diagnostic data, to make the
data machine-readable.   TAP13 specifically avoided defining such a
schema.  I need to look at TAP14 and see if they have defined something.
(Thanks for bringing that to my attention.)

The important part, since there are no start and end delimiters for each
testcase, is to structure output (including from unrelated sub-systems
affected by the test) to either occur all before or all after the test line.
Otherwise it's impossible to sensibly parse the diagnostic data and associate it
with a test.  (That is, the TAP lines become the delimiters between each testcase's
output and data).  This is a pretty big weakness of TAP13.  Since the TAP line
has the test result, it usually means that the subsystem output for the test
is emitted *before* the TAP line.  It's preferable, in order to keep the
data together, that the diagnostic data also be emitted before the TAP
line.

> 
> We can hold off on the YAML stuff for now then.
> 
> > > ## Here is what I propose for this patchset:
> > >
> > >  - Print out test number range at the beginning of each test suite.
> > >  - Print out log lines as soon as they happen as diagnostics.
> > >  - Print out the lines that state whether a test passes or fails as a
> > > ok/not ok line.
> > >
> > > This would be technically conforming with TAP13 and is consistent with
> > > what some kselftests have done.
> > >
> > > ## To be done in a future patchset:
> > >
> > > Add a YAML serializer and print out some logs containing structured
> > > data (like expectation failures, unexpected function calls, etc) in
> > > YAML blocks.
> >
> > YAML serializer sounds like not needed complexity.
I agree, for now.

I think if we start to see some patterns for some data that many tests
output, we might want (as a kernel community) to define a YAML
schema for the kselftest output.  But I think that's biting off too much
right now.  IMHO we would want any YAML schema we define to
cover more than just unit tests, so the job of defining that would be
pretty big.

This would be a good discussion to have at a testing micro-conference
or summit. :-)

> >
> > >
> > > Does this sound reasonable? I will go ahead and start working on this,
> > > but feel free to give me feedback on the overall idea in the meantime.

Sounds good.  Thanks for working on this.
 -- Tim

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
