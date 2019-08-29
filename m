Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A1EA22FC
	for <lists+linux-nvdimm@lfdr.de>; Thu, 29 Aug 2019 20:08:11 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C14782021DD46;
	Thu, 29 Aug 2019 11:10:01 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=134.134.136.20; helo=mga02.intel.com;
 envelope-from=vishal.l.verma@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 4752C20218C5B
 for <linux-nvdimm@lists.01.org>; Thu, 29 Aug 2019 11:10:01 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 29 Aug 2019 11:08:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,444,1559545200"; d="scan'208";a="182420797"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
 by fmsmga007.fm.intel.com with ESMTP; 29 Aug 2019 11:08:08 -0700
Received: from fmsmsx114.amr.corp.intel.com (10.18.116.8) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 29 Aug 2019 11:08:08 -0700
Received: from fmsmsx113.amr.corp.intel.com ([169.254.13.127]) by
 FMSMSX114.amr.corp.intel.com ([169.254.6.244]) with mapi id 14.03.0439.000;
 Thu, 29 Aug 2019 11:08:07 -0700
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "jane.chu@oracle.com" <jane.chu@oracle.com>, "linux-nvdimm@lists.01.org"
 <linux-nvdimm@lists.01.org>
Subject: Re: [ndctl PATCH 3/3] ndctl/namespace: add a --continue option to
 create namespaces greedily
Thread-Topic: [ndctl PATCH 3/3] ndctl/namespace: add a --continue option to
 create namespaces greedily
Thread-Index: AQHVXf8uIV6SmGbMik61vVYfKtf7O6cS2ooAgAAIO4A=
Date: Thu, 29 Aug 2019 18:08:07 +0000
Message-ID: <e343ace46d7243632eec594f679759fac78814ba.camel@intel.com>
References: <20190829001735.30289-1-vishal.l.verma@intel.com>
 <20190829001735.30289-4-vishal.l.verma@intel.com>
 <179261bd-9812-6bba-6710-19a77cf3acc6@oracle.com>
In-Reply-To: <179261bd-9812-6bba-6710-19a77cf3acc6@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.5 (3.30.5-1.fc29) 
x-originating-ip: [10.232.112.185]
Content-ID: <7589F471D9602B44A2BE10FB912FA08D@intel.com>
MIME-Version: 1.0
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
Cc: "Scargall, Steve" <steve.scargall@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Thu, 2019-08-29 at 10:38 -0700, jane.chu@oracle.com wrote:
> Hi, Vishal,
> 
> 
> On 8/28/19 5:17 PM, Vishal Verma wrote:
> > Add a --continue option to ndctl-create-namespaces to allow the creation
> > of as many namespaces as possible, that meet the given filter
> > restrictions.
> > 
> > The creation loop will be aborted if a failure is encountered at any
> > point.
> 
> Just wondering what is the motivation behind providing this option?

Hi Jane,

See Steve's email here:
https://lists.01.org/pipermail/linux-nvdimm/2019-August/023390.html

Essentially it lets sysadmins create a simple, maximal configuration
without everyone having to script it.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
