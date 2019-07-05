Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CDEA60C43
	for <lists+linux-nvdimm@lfdr.de>; Fri,  5 Jul 2019 22:20:57 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A3007212B2057;
	Fri,  5 Jul 2019 13:20:55 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=209.85.210.193; helo=mail-pf1-f193.google.com;
 envelope-from=mcgrof@gmail.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com
 [209.85.210.193])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 25A57212ACEB2
 for <linux-nvdimm@lists.01.org>; Fri,  5 Jul 2019 13:20:54 -0700 (PDT)
Received: by mail-pf1-f193.google.com with SMTP id y15so4747049pfn.5
 for <linux-nvdimm@lists.01.org>; Fri, 05 Jul 2019 13:20:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=25Gxg4cOnHkRGBzoLvP39q6ZGr7xTfO8zZqC3Dmp4ao=;
 b=G9rD2iR2/VTF5oU021H2FOuKFAaDzrwOUHLEFfcrfIYRghPeXwIna+dnaSKVqpPt3s
 3O6sQ+cxtx/kJqP8e6iB/EJlRLtD+/wnrxHCMW/gSiZxsvtfS2TzG6OmqRgHxULW4kmt
 pxX9l0l3NKYfdsStdFel5noBbNxw1jbz1eVXkhdBD6FJM/mWOjPg0ed0LjFxeDwwRszR
 vtnCQHA/4t2DTzGXlSjYsWm9ybhnFxPWNHg6NsqPoUO6W2zDmtO0X4nnLC7q1v3vBgDc
 aBX60zmVgxgBDhpC3AiDotg2b2N/197NCQbtM3HjNx7o/OF85kG1JiYdbRlLGNgkExlg
 yqVg==
X-Gm-Message-State: APjAAAWrr/9D7rLDgW6wgp4GXzrsivrfBRROuOcYmzZi9ColnxkKNkRH
 9UEYZmrYo3v60k+RdnF1nwc=
X-Google-Smtp-Source: APXvYqzDgP2UvvEnLjwLbSAV5+PRQhqdSDKK5VAZmMuJMa1jdDqx9hxhnLoRC5+cLLJisPXah8LMOQ==
X-Received: by 2002:a63:e506:: with SMTP id r6mr7427654pgh.324.1562358053447; 
 Fri, 05 Jul 2019 13:20:53 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
 by smtp.gmail.com with ESMTPSA id r188sm18308824pfr.16.2019.07.05.13.20.52
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 05 Jul 2019 13:20:52 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
 id A47FE40190; Fri,  5 Jul 2019 20:20:51 +0000 (UTC)
Date: Fri, 5 Jul 2019 20:20:51 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: Brendan Higgins <brendanhiggins@google.com>
Subject: Re: [PATCH v6 01/18] kunit: test: add KUnit test runner core
Message-ID: <20190705202051.GB19023@42.do-not-panic.com>
References: <20190704003615.204860-1-brendanhiggins@google.com>
 <20190704003615.204860-2-brendanhiggins@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190704003615.204860-2-brendanhiggins@google.com>
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

On Wed, Jul 03, 2019 at 05:35:58PM -0700, Brendan Higgins wrote:
> +struct kunit {
> +	void *priv;
> +
> +	/* private: internal use only. */
> +	const char *name; /* Read only after initialization! */
> +	bool success; /* Read only after test_case finishes! */
> +};

No lock attribute above.

> +void kunit_init_test(struct kunit *test, const char *name)
> +{
> +	spin_lock_init(&test->lock);
> +	test->name = name;
> +	test->success = true;
> +}

And yet here you initialize a spin lock... This won't compile. Seems
you forgot to remove this line. So I guess a re-spin is better.

  Luis
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
