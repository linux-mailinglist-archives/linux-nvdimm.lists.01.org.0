Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9432012139
	for <lists+linux-nvdimm@lfdr.de>; Thu,  2 May 2019 19:44:41 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C123C21243BD8;
	Thu,  2 May 2019 10:44:39 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2a00:1450:4864:20::535; helo=mail-ed1-x535.google.com;
 envelope-from=pasha.tatashin@soleen.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 1C92A21243BD3
 for <linux-nvdimm@lists.01.org>; Thu,  2 May 2019 10:44:37 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id b8so2846130edm.11
 for <linux-nvdimm@lists.01.org>; Thu, 02 May 2019 10:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=soleen.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=DaSPhFrdJ9xcb9w7nOB/hv2LmsH6V06QJTIIuydXt8E=;
 b=QXat18OMVYiFj1J2lwckErIND4VxtD7m3nZmTH2CGaJZ+Hw7fVyhiWqHLoK622HkMp
 U9yMIC+ePTVWRGsI21RjnrUuMDsRxTmmjgzsyI3fQ3Qprp0+kiDd7tOOuYY19ZJMOfhl
 l/1rt08HauRtiP2hRqk2NjpJPuP+O+9ngov5zkBNLTuR7qrPf6ExGNub4tU8rsI/TrCn
 n8s8mKEfj18Fxht+PV1z/8GAgInkc9Qc/e9giORQoOAL+mVUg59lDwUFBXIKKGSVU4af
 HayfIxQWJSZlQl6kr16/h15Hk5Reu50LKaP/QJCHnyPavmaX8LyepIFk7cqxBrWSjJxB
 gfgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DaSPhFrdJ9xcb9w7nOB/hv2LmsH6V06QJTIIuydXt8E=;
 b=l4D5fD2Ao5eCaO5tdOwoC+KYmT10YWQKI34shLbGfOKOliuD2l7fNaIl0IGCcGLFmw
 E+l3cmOsFFEh7tEjUocyebH1VgWbGd+Tl7520vOvq1gJOA/VCN3iyiiLA6Ww4YZuTKcO
 OR1fT2hq7pYAf/JMRIwV73u4pTRPFejaW+N2a5hE0E6zu+MqwBTJM7CXRzMhbjTvst6L
 U98XS7XO9jroWbEdC3/ojlTtPM91Fn5sOkW8oBRKda5Hkyk04oLfTk9Hm5XMxgj/conv
 vltf7EbFg+oONZuWFFAOFNqDZTywHQknGu96NsCMEJRyHw4iROS4HV1vSdCbvRQBfJ8v
 Mv4g==
X-Gm-Message-State: APjAAAWWQUhhxmTzum70sG81gcgB9oEqJhIoz/RrMqtJ9em95KAu2eLW
 WxQuMRDHW814j7dOc/dtYV4vlxdjqVTlzmdA3uzCPg==
X-Google-Smtp-Source: APXvYqwFjCWrvwlJewJq8jESh0fLZdmcYO3yLeAKyzDonK3UsuXpek6fTdQl1z2LIrzbiszd7BG6f/7lz+swTO1hQHI=
X-Received: by 2002:a50:a951:: with SMTP id m17mr3313780edc.79.1556819075931; 
 Thu, 02 May 2019 10:44:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190501191846.12634-1-pasha.tatashin@soleen.com>
 <20190501191846.12634-3-pasha.tatashin@soleen.com>
 <20190502173419.GA3048@sasha-vm>
In-Reply-To: <20190502173419.GA3048@sasha-vm>
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 2 May 2019 13:44:24 -0400
Message-ID: <CA+CK2bA-jVEXvF-gi1N=8jD-+MPsqtn0aod=iBNJ0TrgiqqBSg@mail.gmail.com>
Subject: Re: [v4 2/2] device-dax: "Hotremove" persistent memory that is used
 like normal RAM
To: Sasha Levin <sashal@kernel.org>
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
Cc: Tom Lendacky <thomas.lendacky@amd.com>, Michal Hocko <mhocko@suse.com>,
 linux-nvdimm <linux-nvdimm@lists.01.org>, Takashi Iwai <tiwai@suse.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "Huang,
 Ying" <ying.huang@intel.com>, James Morris <jmorris@namei.org>,
 David Hildenbrand <david@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
 linux-mm <linux-mm@kvack.org>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Borislav Petkov <bp@suse.de>, Yaowei Bai <baiyaowei@cmss.chinamobile.com>,
 Ross Zwisler <zwisler@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Fengguang Wu <fengguang.wu@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

> >device-dax/kmem driver. So, operations should look like this:
> >
> >echo offline > echo offline > /sys/devices/system/memory/memoryN/state

>
> This looks wrong :)
>

Indeed, I  will fix patch log in the next version.

Thank you,
Pasha
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
