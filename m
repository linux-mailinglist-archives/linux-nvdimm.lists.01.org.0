Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A6D1B0F9A
	for <lists+linux-nvdimm@lfdr.de>; Thu, 12 Sep 2019 15:10:27 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B0384202E2929;
	Thu, 12 Sep 2019 06:10:27 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=209.85.210.194; helo=mail-pf1-f194.google.com;
 envelope-from=bart.vanassche@gmail.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com
 [209.85.210.194])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id A7842202E291C
 for <linux-nvdimm@lists.01.org>; Thu, 12 Sep 2019 06:10:26 -0700 (PDT)
Received: by mail-pf1-f194.google.com with SMTP id y22so16020390pfr.3
 for <linux-nvdimm@lists.01.org>; Thu, 12 Sep 2019 06:10:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=o85hg2uRViTBTOdRLoeY1KBtWVrAtpQuUFP49tE28+E=;
 b=hfHsaht8NQr4NueUaAAeGjA+RUxwXrMYid0nyCB+IpKKdKs7xT62GCfyZlVC7iHs1p
 1LuqVCqyowuDNNetpa29JE65teucZZRl+FOtdzrRwU/VP3K7SNnaDzl1sEbB08Qc3Vva
 E3kvpfHejCNQFnNVuwUMhMigTIy+9CuTk6KiRtRxchTdsmRl4ja4tL/ug6HLmdIf1dl0
 LUErVwR2DpddD2bY2zeWXcxsGGWpPIPqS5ZBBcABohhOE9fYymAzba4s1yqWO2PfvKnl
 i3WiPYv5dx4qXNSNb7V2cXJzxO8DlFYPqY4hkHyNGJ3UskBcY10BZxfw6tRK6A8ugJJp
 6IPA==
X-Gm-Message-State: APjAAAXq4WagdyDLp6bNZrY5j1JWcmWpaE9zSGM//ooV6owNfy+V/8qA
 7kNne0VOm8Bk40zLepLA64o=
X-Google-Smtp-Source: APXvYqzrRMGtNABoRFUEmvlswO8y/ZbF7TMze/iCEdYvrjifxzi3YYQpajJ4r+D8tdbIIPZ/7cqrJA==
X-Received: by 2002:a63:460c:: with SMTP id t12mr37672408pga.69.1568293823578; 
 Thu, 12 Sep 2019 06:10:23 -0700 (PDT)
Received: from [172.19.249.100] ([38.98.37.138])
 by smtp.gmail.com with ESMTPSA id u65sm28133705pfu.104.2019.09.12.06.10.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Sep 2019 06:10:22 -0700 (PDT)
Subject: Re: [Ksummit-discuss] [PATCH v2 0/3] Maintainer Entry Profiles
To: Dan Williams <dan.j.williams@intel.com>, linux-kernel@vger.kernel.org
References: <156821692280.2951081.18036584954940423225.stgit@dwillia2-desk3.amr.corp.intel.com>
From: Bart Van Assche <bvanassche@acm.org>
Message-ID: <92fb4141-8e2d-1139-2f55-b7100be8a2fd@acm.org>
Date: Thu, 12 Sep 2019 14:10:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <156821692280.2951081.18036584954940423225.stgit@dwillia2-desk3.amr.corp.intel.com>
Content-Language: en-US
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
Cc: ksummit-discuss@lists.linuxfoundation.org, linux-nvdimm@lists.01.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dmitry Vyukov <dvyukov@google.com>, Mauro Carvalho Chehab <mchehab@kernel.org>,
 Steve French <stfrench@microsoft.com>, "Tobin C. Harding" <me@tobin.cc>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On 9/11/19 4:48 PM, Dan Williams wrote:
> At last years Plumbers Conference I proposed the Maintainer Entry
> Profile as a document that a maintainer can provide to set contributor
> expectations and provide fodder for a discussion between maintainers
> about the merits of different maintainer policies.
> 
> For those that did not attend, the goal of the Maintainer Entry Profile,
> and the Maintainer Handbook more generally, is to provide a desk
> reference for maintainers both new and experienced. The session
> introduction was:
> 
>     The first rule of kernel maintenance is that there are no hard and
>     fast rules. That state of affairs is both a blessing and a curse. It
>     has served the community well to be adaptable to the different
>     people and different problem spaces that inhabit the kernel
>     community. However, that variability also leads to inconsistent
>     experiences for contributors, little to no guidance for new
>     contributors, and unnecessary stress on current maintainers. There
>     are quite a few of people who have been around long enough to make
>     enough mistakes that they have gained some hard earned proficiency.
>     However if the kernel community expects to keep growing it needs to
>     be able both scale the maintainers it has and ramp new ones without
>     necessarily let them make a decades worth of mistakes to learn the
>     ropes. 
> 
> To be clear, the proposed document does not impose or suggest new
> rules. Instead it provides an outlet to document the unwritten rules
> and policies in effect for each subsystem, and that each subsystem
> might decide differently for whatever reason.

Any maintainer who reads this might interpret this as an encouragement
to establish custom policies. I think one of the conclusions of the
Linux Plumbers 2019 edition is that too much diversity is bad and that
we need more uniformity across kernel subsystems with regard what is
expected from patch contributors. I would appreciate if a summary of
https://linuxplumbersconf.org/event/4/contributions/554/attachments/353/584/Reflections__Kernel_Summit_2019.pdf
would be integrated in the maintainer handbook.

Thanks,

Bart.

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
