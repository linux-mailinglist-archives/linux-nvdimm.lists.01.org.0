Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 899501B8E7
	for <lists+linux-nvdimm@lfdr.de>; Mon, 13 May 2019 16:45:02 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8173921273417;
	Mon, 13 May 2019 07:45:00 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: None (no SPF record) identity=mailfrom;
 client-ip=2a00:1450:4864:20::543; helo=mail-ed1-x543.google.com;
 envelope-from=daniel@ffwll.ch; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com
 [IPv6:2a00:1450:4864:20::543])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id D2CDA21260505
 for <linux-nvdimm@lists.01.org>; Mon, 13 May 2019 07:44:58 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id g57so17925646edc.12
 for <linux-nvdimm@lists.01.org>; Mon, 13 May 2019 07:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=sender:date:from:to:subject:message-id:mail-followup-to:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=oa11tgFM6isQYlc2/lSr8+dtL7dz0FGS2ImXszdei94=;
 b=lkK1jfdXRSWG4EOPXpNEsgoMZb8lUzm2FfYavTsrFBTY7w3Z4FVJ9cp/fBcnbUD9bK
 Frxw45KRQigXleUJaVccMl3gMpsrT0DKhj92T3OICo7PFH1ZWYiDKuhrJn4Bo6DXp0gB
 BN+9OOpk6LCzBYskBvabimkY7bAvWM5tFDS84=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:subject:message-id
 :mail-followup-to:references:mime-version:content-disposition
 :in-reply-to:user-agent;
 bh=oa11tgFM6isQYlc2/lSr8+dtL7dz0FGS2ImXszdei94=;
 b=Y7wLGrKS2QhBvMIjxH4925xYHKjBbnyqvZlazTgFhFHhORu88KHeiWapEP9+xOgeQY
 CEyYMo25iwr8zKfiuPO+4UKs0X6nvUPr90uFzNNF+tvGHxH66SFp61NvGEf4/WdcWr3s
 cnXiOZ1Nde2aADZIo6xBwQKqb7Qw01fSUGLy9+6O/bZ4wYvbz89ssvnBHoI7Xf8YLEwH
 WkXP7l4K3EzDfq8K1ha6+/xkNKUox9wI3IZM/u+BVslzkyxuoRXWdcdY9Gyjw2+Vp68e
 DN+6Ow8v8zYPwbIABWR2BqI5RNacDDj4VoQosiE12wQ+H03iqyoLSeRkeET7bouSp8Zh
 zASA==
X-Gm-Message-State: APjAAAXtlGYP+p9lIiNVJh2qQ7xcvDNIbVhpCmnYNUVKn2ymoJkKvURU
 PONMd+okO9U3u4qNEMlzuiqzMA==
X-Google-Smtp-Source: APXvYqzazE/ARkr3DfLFYQv2UcXLE6AXccxEO07VmSzGlXapLczjo2jaDfA5V6TtDA06sVwBcw/rGw==
X-Received: by 2002:a17:906:18b1:: with SMTP id
 c17mr22862891ejf.196.1557758696660; 
 Mon, 13 May 2019 07:44:56 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
 by smtp.gmail.com with ESMTPSA id ox15sm1844293ejb.52.2019.05.13.07.44.54
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 13 May 2019 07:44:55 -0700 (PDT)
Date: Mon, 13 May 2019 16:44:51 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Theodore Ts'o <tytso@mit.edu>, Frank Rowand <frowand.list@gmail.com>,
 Tim.Bird@sony.com, knut.omang@oracle.com,
 gregkh@linuxfoundation.org, brendanhiggins@google.com,
 keescook@google.com, kieran.bingham@ideasonboard.com,
 mcgrof@kernel.org, robh@kernel.org, sboyd@kernel.org,
 shuah@kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, kunit-dev@googlegroups.com,
 linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org,
 linux-um@lists.infradead.org, Alexander.Levin@microsoft.com,
 amir73il@gmail.com, dan.carpenter@oracle.com,
 dan.j.williams@intel.com, daniel@ffwll.ch, jdike@addtoit.com,
 joel@jms.id.au, julia.lawall@lip6.fr, khilman@baylibre.com,
 logang@deltatee.com, mpe@ellerman.id.au, pmladek@suse.com,
 richard@nod.at, rientjes@google.com, rostedt@goodmis.org,
 wfg@linux.intel.com
Subject: Re: [PATCH v2 00/17] kunit: introduce KUnit, the Linux kernel unit
 testing framework
Message-ID: <20190513144451.GQ17751@phenom.ffwll.local>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
 Frank Rowand <frowand.list@gmail.com>, Tim.Bird@sony.com,
 knut.omang@oracle.com, gregkh@linuxfoundation.org,
 brendanhiggins@google.com, keescook@google.com,
 kieran.bingham@ideasonboard.com, mcgrof@kernel.org, robh@kernel.org,
 sboyd@kernel.org, shuah@kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, kunit-dev@googlegroups.com,
 linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org,
 linux-um@lists.infradead.org, Alexander.Levin@microsoft.com,
 amir73il@gmail.com, dan.carpenter@oracle.com,
 dan.j.williams@intel.com, jdike@addtoit.com, joel@jms.id.au,
 julia.lawall@lip6.fr, khilman@baylibre.com, logang@deltatee.com,
 mpe@ellerman.id.au, pmladek@suse.com, richard@nod.at,
 rientjes@google.com, rostedt@goodmis.org, wfg@linux.intel.com
References: <20190509015856.GB7031@mit.edu>
 <580e092f-fa4e-eedc-9e9a-a57dd085f0a6@gmail.com>
 <20190509032017.GA29703@mit.edu>
 <7fd35df81c06f6eb319223a22e7b93f29926edb9.camel@oracle.com>
 <20190509133551.GD29703@mit.edu>
 <ECADFF3FD767C149AD96A924E7EA6EAF9770D591@USCULXMSG01.am.sony.com>
 <875c546d-9713-bb59-47e4-77a1d2c69a6d@gmail.com>
 <20190509214233.GA20877@mit.edu>
 <80c72e64-2665-bd51-f78c-97f50f9a53ba@gmail.com>
 <20190511173344.GA8507@mit.edu>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190511173344.GA8507@mit.edu>
X-Operating-System: Linux phenom 4.14.0-3-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
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

On Sat, May 11, 2019 at 01:33:44PM -0400, Theodore Ts'o wrote:
> On Fri, May 10, 2019 at 02:12:40PM -0700, Frank Rowand wrote:
> > However, the reply is incorrect.  Kselftest in-kernel tests (which
> > is the context here) can be configured as built in instead of as
> > a module, and built in a UML kernel.  The UML kernel can boot,
> > running the in-kernel tests before UML attempts to invoke the
> > init process.
> 
> Um, Citation needed?
> 
> I don't see any evidence for this in the kselftest documentation, nor
> do I see any evidence of this in the kselftest Makefiles.
> 
> There exists test modules in the kernel that run before the init
> scripts run --- but that's not strictly speaking part of kselftests,
> and do not have any kind of infrastructure.  As noted, the
> kselftests_harness header file fundamentally assumes that you are
> running test code in userspace.

Yeah I really like the "no userspace required at all" design of kunit,
while still collecting results in a well-defined way (unless the current
self-test that just run when you load the module, with maybe some
kselftest ad-hoc wrapper around to collect the results).

What I want to do long-term is to run these kernel unit tests as part of
the build-testing, most likely in gitlab (sooner or later, for drm.git
only ofc). So that people get their pull requests (and patch series, we
have some ideas to tie this into patchwork) automatically tested for this
super basic stuff.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
