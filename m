Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B926F96887
	for <lists+linux-nvdimm@lfdr.de>; Tue, 20 Aug 2019 20:25:00 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 598B521962301;
	Tue, 20 Aug 2019 11:26:16 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::442; helo=mail-pf1-x442.google.com;
 envelope-from=brendanhiggins@google.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 3BD872020D32C
 for <linux-nvdimm@lists.01.org>; Tue, 20 Aug 2019 11:26:15 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id w2so3881040pfi.3
 for <linux-nvdimm@lists.01.org>; Tue, 20 Aug 2019 11:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=54TsZDfDW3TriN1nqx27Ow/a4BBsLJIgLp0TtrQghOk=;
 b=ETn6ov6vEQVZ6Z8d+QOJIR5ZdOHT4ZDivDB2VkpQ0qnDIs9MQrQ638udwnr/9nsV39
 Q9CE1bjJjQqBou8vTO6RAPzU8X9Tiq1MLFyQK2/DJWm5diN99WuwayJaLt2azZswGQO6
 PgJRFVxL4YQGtCWP5gy6mT//u52PocvwVbmI1tMnbwHSew1qhj9G4kLkgm0cfOXOG/+z
 KBuOacguM7Ku15bvGQe9U+2RVhwBdPlfoBEveO5qY2aaNvMSGTBP0IPNRwdL5M9uwBLI
 rRbk5djqLbCbCvoJbmUcAx9Gb5ONtUGkfOKYOiRtBndtwfw3IyR9R3OQOevfv1X/iVGx
 ii2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=54TsZDfDW3TriN1nqx27Ow/a4BBsLJIgLp0TtrQghOk=;
 b=ZdZSEyGKwL0U4o3hl3C3SjTKIX+RtC1L0yLGrf0JvPHeaoHQoXY32TnxD8Aq0gtZnT
 /2/Tk4BP1mNaoPOOj0Hg17QgOm73koDUmj5OkDXw/qkGoGwNC7ZetUhu9KhVFzcx+QKd
 9kqvrTXKQLYicxErVDcvoW3eU/CY8XPD7NXmbMuqH10UkuN46Upl/L2G3iLHqu0ND4jP
 0rawyqF+GAQupWKJfndS5r5jtwg91Mk1ZQx9Rjb7EA+rE7GqsBMFFjK7QtyUEbE8SIz0
 VyC77ctfIfsNm3dUiYLrfbBiYeGVjedXY9DhJRfea8/Ogcn7ct5Dy07+CIE/STRft82c
 Ytsw==
X-Gm-Message-State: APjAAAVAuf/lJD+O9CaDrCMK+QYHoysemN8EWV0Y9sz090sJKHK7OqDv
 QNVBnO+XNhWwh0jDcY+tGHec2Q==
X-Google-Smtp-Source: APXvYqz6e4UEkK1ofDpL52W0zxkSIj5ZMAzgsILYeZML13HEn/+04ibT+w1ZAtBgHDGP+VY3TZZ4jA==
X-Received: by 2002:a17:90a:3aaf:: with SMTP id
 b44mr1312628pjc.87.1566325496873; 
 Tue, 20 Aug 2019 11:24:56 -0700 (PDT)
Received: from google.com ([2620:15c:2cb:1:e90c:8e54:c2b4:29e7])
 by smtp.gmail.com with ESMTPSA id u16sm20305376pgm.83.2019.08.20.11.24.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Aug 2019 11:24:55 -0700 (PDT)
Date: Tue, 20 Aug 2019 11:24:50 -0700
From: Brendan Higgins <brendanhiggins@google.com>
To: shuah <shuah@kernel.org>
Subject: Re: [PATCH v13 00/18] kunit: introduce KUnit, the Linux kernel unit
 testing framework
Message-ID: <20190820182450.GA38078@google.com>
References: <20190814055108.214253-1-brendanhiggins@google.com>
 <5b880f49-0213-1a6e-9c9f-153e6ab91eeb@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5b880f49-0213-1a6e-9c9f-153e6ab91eeb@kernel.org>
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
 amir73il@gmail.com, dri-devel@lists.freedesktop.org,
 Alexander.Levin@microsoft.com, yamada.masahiro@socionext.com,
 mpe@ellerman.id.au, linux-kselftest@vger.kernel.org, frowand.list@gmail.com,
 robh@kernel.org, linux-nvdimm@lists.01.org, khilman@baylibre.com,
 knut.omang@oracle.com, kieran.bingham@ideasonboard.com, wfg@linux.intel.com,
 joel@jms.id.au, rientjes@google.com, jdike@addtoit.com,
 dan.carpenter@oracle.com, devicetree@vger.kernel.org,
 linux-kbuild@vger.kernel.org, Tim.Bird@sony.com, linux-um@lists.infradead.org,
 rostedt@goodmis.org, julia.lawall@lip6.fr, jpoimboe@redhat.com,
 Bjorn Helgaas <bhelgaas@google.com>, kunit-dev@googlegroups.com, tytso@mit.edu,
 richard@nod.at, sboyd@kernel.org, gregkh@linuxfoundation.org,
 rdunlap@infradead.org, linux-kernel@vger.kernel.org, mcgrof@kernel.org,
 daniel@ffwll.ch, keescook@google.com, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Tue, Aug 20, 2019 at 11:24:45AM -0600, shuah wrote:
> On 8/13/19 11:50 PM, Brendan Higgins wrote:
> > ## TL;DR
> > 
> > This revision addresses comments from Stephen and Bjorn Helgaas. Most
> > changes are pretty minor stuff that doesn't affect the API in anyway.
> > One significant change, however, is that I added support for freeing
> > kunit_resource managed resources before the test case is finished via
> > kunit_resource_destroy(). Additionally, Bjorn pointed out that I broke
> > KUnit on certain configurations (like the default one for x86, whoops).
> > 
> > Based on Stephen's feedback on the previous change, I think we are
> > pretty close. I am not expecting any significant changes from here on
> > out.
> > 
> 
> Hi Brendan,
> 
> I found checkpatch errors in one or two patches. Can you fix those and
> send v14.

Hi Shuah,

Are you refering to the following errors?

ERROR: Macros with complex values should be enclosed in parentheses
#144: FILE: include/kunit/test.h:456:
+#define KUNIT_BINARY_CLASS \
+       kunit_binary_assert, KUNIT_INIT_BINARY_ASSERT_STRUCT

ERROR: Macros with complex values should be enclosed in parentheses
#146: FILE: include/kunit/test.h:458:
+#define KUNIT_BINARY_PTR_CLASS \
+       kunit_binary_ptr_assert, KUNIT_INIT_BINARY_PTR_ASSERT_STRUCT

These values should *not* be in parentheses. I am guessing checkpatch is
getting confused and thinks that these are complex expressions, when
they are not.

I ignored the errors since I figured checkpatch was complaining
erroneously.

I could refactor the code to remove these macros entirely, but I think
the code is cleaner with them.

What would you prefer I do?

NB: These macros are introduced in: "[PATCH v13 05/18] kunit: test: add
the concept of expectations"

Thanks!
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
