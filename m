Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D7AC760C92
	for <lists+linux-nvdimm@lfdr.de>; Fri,  5 Jul 2019 22:45:42 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3DC54212B2059;
	Fri,  5 Jul 2019 13:45:41 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=209.85.210.193; helo=mail-pf1-f193.google.com;
 envelope-from=mcgrof@gmail.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com
 [209.85.210.193])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id F306F2194EB7A
 for <linux-nvdimm@lists.01.org>; Fri,  5 Jul 2019 13:45:39 -0700 (PDT)
Received: by mail-pf1-f193.google.com with SMTP id c73so99581pfb.13
 for <linux-nvdimm@lists.01.org>; Fri, 05 Jul 2019 13:45:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=NINMgNCtdp9VxxGck6fqsoIqX8vCQf36P/6C5pYBqDM=;
 b=Cwi+1DhfpGa9u2QpFEZNqJMjIkIHeNWhSf2hYWNIYbB/XPe3KP+CXT5yusbOx91ceh
 RV0mJTv0d69LtqPNmalN9WFO4axEvKBCYNBdgoMIq01jM8ALRkgyqWEyFBSemw56a6wj
 VJz8AjeKbF9/KufiBo9tJbk1vk14LYCoQKbn59DeTmJsqwNGKMqRpIbMPWU+cCeVTJxD
 vjHFw3ecr1aYfUmplS87t6SBINC7NFfqeCjjJSOPkb3AZxRz/KG2mhM04pqUT8LakOaA
 jfVerkBtyzVH9SKtk1cNGziP2JCpHzIgWpu2ENnLnSFZFH3YQxyGeH3ProXMDXPayLdD
 esdg==
X-Gm-Message-State: APjAAAUIVQ/1e0MRbPra8jT/Vj32avcvcVjeikPb+1iNHERG1HcRD72A
 EKTItjZbPVHAo8LinZu0sz8=
X-Google-Smtp-Source: APXvYqzORz85r9dXJ+0VShptntCI2Ba5VbMOY6v1/mI3RdkuGvkVnROUEZV4rccMgxpa1+keGNumHQ==
X-Received: by 2002:a17:90a:d58c:: with SMTP id v12mr89451pju.7.1562359539502; 
 Fri, 05 Jul 2019 13:45:39 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
 by smtp.gmail.com with ESMTPSA id b17sm14479029pgj.73.2019.07.05.13.45.38
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 05 Jul 2019 13:45:38 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
 id 9D53F40190; Fri,  5 Jul 2019 20:45:37 +0000 (UTC)
Date: Fri, 5 Jul 2019 20:45:37 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: Brendan Higgins <brendanhiggins@google.com>
Subject: Re: [PATCH v6 02/18] kunit: test: add test resource management API
Message-ID: <20190705204537.GC19023@42.do-not-panic.com>
References: <20190704003615.204860-1-brendanhiggins@google.com>
 <20190704003615.204860-3-brendanhiggins@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190704003615.204860-3-brendanhiggins@google.com>
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

On Wed, Jul 03, 2019 at 05:35:59PM -0700, Brendan Higgins wrote:
> diff --git a/kunit/test.c b/kunit/test.c
> index c030ba5a43e40..a70fbe449e922 100644
> --- a/kunit/test.c
> +++ b/kunit/test.c
> @@ -122,7 +122,8 @@ static void kunit_print_test_case_ok_not_ok(struct kunit_case *test_case,
>  
>  void kunit_init_test(struct kunit *test, const char *name)
>  {
> -	spin_lock_init(&test->lock);

Once you re-spin, this above line should be removed.

> +	mutex_init(&test->lock);
> +	INIT_LIST_HEAD(&test->resources);
>  	test->name = name;
>  	test->success = true;
>  }

  Luis
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
