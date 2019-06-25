Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A63A755C32
	for <lists+linux-nvdimm@lfdr.de>; Wed, 26 Jun 2019 01:22:56 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 14F2C212A36EF;
	Tue, 25 Jun 2019 16:22:55 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=209.85.210.195; helo=mail-pf1-f195.google.com;
 envelope-from=mcgrof@gmail.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com
 [209.85.210.195])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id C7004211F35FF
 for <linux-nvdimm@lists.01.org>; Tue, 25 Jun 2019 16:22:52 -0700 (PDT)
Received: by mail-pf1-f195.google.com with SMTP id d126so220107pfd.2
 for <linux-nvdimm@lists.01.org>; Tue, 25 Jun 2019 16:22:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=fn8uhj8tc3U3pScoaEkKu7HBQ+Qs1BqmjB6lHJFC6hE=;
 b=oIU87NVcPBbxQxoz/Qw9Lss0tcZ+x6wybooQB8LXKkT3B1WWLO5nBnjgRn9Al8p0pL
 8a6fyAxmMU1ymeA61vHvKWxfrlVZEpFd/TMJiVyD2gx2UPGn+hUr0pMxQpNr274ZoAle
 i6h8Iyq5q8y/yuKaSvy+PtcNO/C+J2tHmLZQFISEIdqzqTq6TUeULyuklx+Adltn+GiY
 zx8sCC50dT2iscsXzv5RqSNOyelH28L31DBRCs9h6QDv01T/vo3iOG8gSe3cLm3qnmsn
 c8nLp0nek89JTOiKyxS7r/ryIH0EMml91hx+2c14hS2sU35iIwcSdNbmBR3Uv3GvOlTY
 UEiQ==
X-Gm-Message-State: APjAAAXxDoP72FizLw6HDYneAKzy89P4fYO9ep0XPBosW4VR5TXaWY8S
 Sg/Wzp/KuyJdVjeeVKsicxY=
X-Google-Smtp-Source: APXvYqw6Otr6YJTjtY/OOBjSfZ7I1hNT7sLUZRcJRcDWNwR1ZNzZuSus00kEpYiN835NFFYZuHxFdA==
X-Received: by 2002:a63:8f09:: with SMTP id n9mr40832306pgd.249.1561504971968; 
 Tue, 25 Jun 2019 16:22:51 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
 by smtp.gmail.com with ESMTPSA id 5sm15215827pfh.109.2019.06.25.16.22.50
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 25 Jun 2019 16:22:50 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
 id D058A401EB; Tue, 25 Jun 2019 23:22:49 +0000 (UTC)
Date: Tue, 25 Jun 2019 23:22:49 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: Brendan Higgins <brendanhiggins@google.com>
Subject: Re: [PATCH v5 07/18] kunit: test: add initial tests
Message-ID: <20190625232249.GS19023@42.do-not-panic.com>
References: <20190617082613.109131-1-brendanhiggins@google.com>
 <20190617082613.109131-8-brendanhiggins@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190617082613.109131-8-brendanhiggins@google.com>
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
 mpe@ellerman.id.au, linux-kselftest@vger.kernel.org, shuah@kernel.org,
 robh@kernel.org, linux-nvdimm@lists.01.org, frowand.list@gmail.com,
 knut.omang@oracle.com, kieran.bingham@ideasonboard.com, wfg@linux.intel.com,
 joel@jms.id.au, rientjes@google.com, jdike@addtoit.com,
 dan.carpenter@oracle.com, devicetree@vger.kernel.org,
 linux-kbuild@vger.kernel.org, Tim.Bird@sony.com, linux-um@lists.infradead.org,
 rostedt@goodmis.org, julia.lawall@lip6.fr, jpoimboe@redhat.com,
 kunit-dev@googlegroups.com, tytso@mit.edu, richard@nod.at, sboyd@kernel.org,
 gregkh@linuxfoundation.org, rdunlap@infradead.org,
 linux-kernel@vger.kernel.org, daniel@ffwll.ch, keescook@google.com,
 linux-fsdevel@vger.kernel.org, khilman@baylibre.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Mon, Jun 17, 2019 at 01:26:02AM -0700, Brendan Higgins wrote:
> diff --git a/kunit/example-test.c b/kunit/example-test.c
> new file mode 100644
> index 0000000000000..f44b8ece488bb
> --- /dev/null
> +++ b/kunit/example-test.c

<-- snip -->

> +/*
> + * This defines a suite or grouping of tests.
> + *
> + * Test cases are defined as belonging to the suite by adding them to
> + * `kunit_cases`.
> + *
> + * Often it is desirable to run some function which will set up things which
> + * will be used by every test; this is accomplished with an `init` function
> + * which runs before each test case is invoked. Similarly, an `exit` function
> + * may be specified which runs after every test case and can be used to for
> + * cleanup. For clarity, running tests in a test module would behave as follows:
> + *

To be clear this is not the kernel module init, but rather the kunit
module init. I think using kmodule would make this clearer to a reader.

> + * module.init(test);
> + * module.test_case[0](test);
> + * module.exit(test);
> + * module.init(test);
> + * module.test_case[1](test);
> + * module.exit(test);
> + * ...;
> + */

  Luis
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
