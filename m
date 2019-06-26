Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 361B755F0D
	for <lists+linux-nvdimm@lfdr.de>; Wed, 26 Jun 2019 04:38:16 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 968CE2129F11A;
	Tue, 25 Jun 2019 19:38:14 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=209.85.214.194; helo=mail-pl1-f194.google.com;
 envelope-from=mcgrof@gmail.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com
 [209.85.214.194])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 79A0F2129F045
 for <linux-nvdimm@lists.01.org>; Tue, 25 Jun 2019 19:38:12 -0700 (PDT)
Received: by mail-pl1-f194.google.com with SMTP id m7so516621pls.8
 for <linux-nvdimm@lists.01.org>; Tue, 25 Jun 2019 19:38:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=xyvmsuEmijKSbxFAnA4vq/E+5XBo5Wy44kba2nyP6go=;
 b=n7Rv7tnxjo0WWx/AAq/XhFcj0wn8D6Yntto4QV7MfyiWNM6IxMkTX9yfr4sPPapvD1
 qnhP2xMp4KAILphcZ7MPpEXE3Fp8SXhnuky3TGls//qlQeC+s56qKqFVl8WrxIf7/17A
 O4Y2W6HNiDb1VaLzAQEXsobe9ntGVnv5ho3tpPipTkNhgwpXG9JNEAxRbLpPpoovrxms
 x95HxgxU6RpnWfw3ErDPPw2p/P0Tft8UUEHyKZL3eei0dCdGCcOQAM/DAoEV/RZTvl/J
 ejHIFmzdvEBuDpAAbzbs6105EEfDPQyWJp4gyj62oTfvkY0vqt+noFr/6lf0EcxlWSyy
 Sy7w==
X-Gm-Message-State: APjAAAWqCMho2n15hbCUfFVUElc6ZHj9hUDmW9hvhQQXGCv6nFc7dn9b
 zGR4ev/nk0ysc/65x8gHDlo=
X-Google-Smtp-Source: APXvYqzDq44Q6ELr7lMNQzzU3Ay+P/NMrvUlNETj0hOmt7FHk+liK3UY9V/aPmtCKjArXN7tpqRtdw==
X-Received: by 2002:a17:902:e512:: with SMTP id
 ck18mr2107905plb.53.1561516691699; 
 Tue, 25 Jun 2019 19:38:11 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
 by smtp.gmail.com with ESMTPSA id a16sm20081945pfd.68.2019.06.25.19.38.10
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 25 Jun 2019 19:38:10 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
 id BC94340336; Wed, 26 Jun 2019 02:38:09 +0000 (UTC)
Date: Wed, 26 Jun 2019 02:38:09 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH v5 00/18] kunit: introduce KUnit, the Linux kernel unit
 testing framework
Message-ID: <20190626023809.GW19023@42.do-not-panic.com>
References: <20190617082613.109131-1-brendanhiggins@google.com>
 <10feac3e-7621-65e5-fbf0-9c63fcbe09c9@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <10feac3e-7621-65e5-fbf0-9c63fcbe09c9@gmail.com>
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
Cc: pmladek@suse.com, linux-doc@vger.kernel.org, peterz@infradead.org,
 amir73il@gmail.com, Brendan Higgins <brendanhiggins@google.com>,
 dri-devel@lists.freedesktop.org, Alexander.Levin@microsoft.com,
 yamada.masahiro@socionext.com, mpe@ellerman.id.au,
 linux-kselftest@vger.kernel.org, shuah@kernel.org, robh@kernel.org,
 linux-nvdimm@lists.01.org, khilman@baylibre.com, knut.omang@oracle.com,
 kieran.bingham@ideasonboard.com, wfg@linux.intel.com, joel@jms.id.au,
 rientjes@google.com, jdike@addtoit.com, dan.carpenter@oracle.com,
 devicetree@vger.kernel.org, linux-kbuild@vger.kernel.org, Tim.Bird@sony.com,
 linux-um@lists.infradead.org, rostedt@goodmis.org, julia.lawall@lip6.fr,
 jpoimboe@redhat.com, kunit-dev@googlegroups.com, tytso@mit.edu, richard@nod.at,
 sboyd@kernel.org, gregkh@linuxfoundation.org, rdunlap@infradead.org,
 linux-kernel@vger.kernel.org, daniel@ffwll.ch, keescook@google.com,
 linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Wed, Jun 19, 2019 at 06:17:51PM -0700, Frank Rowand wrote:
> It does not matter whether KUnit provides additional things, relative
> to kselftest.  The point I was making is that there appears to be
> _some_ overlap between kselftest and KUnit, and if there is overlap
> then it is worth considering whether the overlap can be unified instead
> of duplicated.

From my experience as an author of several kselftests drivers, one
faily complex, and after reviewing the sysctl kunit test module, I
disagree with this.

Even if there were an overlap, I'd say let the best test harness win.
Just as we have different LSMs that do something similar.

But this is not about that though. Although both are testing code,
they do so in *very* different ways.

The design philosophy and architecture are fundamentally different. The
*only* thing I can think of where there is overlap is that both can test
similar code paths. Beyond that, the layout of how one itemizes tests
could be borrowed, but that would be up to each kselftest author to
decide, in fact some ksefltests do exist which follow similar pattern of
itemizing test cases and running them. Kunit just provides a proper
framework to do this easily but also with a focus on UML. This last
aspect makes kselftests fundamentally orthogonal from an architecture /
design perspective.

After careful review, I cannot personally identify what could be shared
at this point. Can you? If you did identify one part, how do you
recommend to share it?

  Luis
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
