Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 877A755ABB
	for <lists+linux-nvdimm@lfdr.de>; Wed, 26 Jun 2019 00:13:25 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1F6AB212A36DB;
	Tue, 25 Jun 2019 15:13:24 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=209.85.215.193; helo=mail-pg1-f193.google.com;
 envelope-from=mcgrof@gmail.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com
 [209.85.215.193])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id D14F72129DB92
 for <linux-nvdimm@lists.01.org>; Tue, 25 Jun 2019 15:13:21 -0700 (PDT)
Received: by mail-pg1-f193.google.com with SMTP id z19so108559pgl.12
 for <linux-nvdimm@lists.01.org>; Tue, 25 Jun 2019 15:13:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=8gzPjoJjuhl8UL7VUOkU3jqXACXyJKi+qh78CzG1deI=;
 b=NTuoEviQEugjnxOm0U13w3kiDpS3VM+axCvRxWHh3MmXPgpoJy3res3AgbksNAs/gK
 FBC0IPB9aZyiOVeYlb3TiQdlCRDG2J6q0MAoepnmsaQCfOSGbbxe5nji/v95IVlJ2ZGV
 BBQ+H/34tQY3cI+6XwhjzDELduauHzs6r2jTRX0wNfHxLTBk1lfpHpXBXZi64aVIWkE9
 NmZaLCvZd4IYgPJ4T1m3K3g0MnRL0xbbVPnGwH/xq1kcYscYyU2qOY8nwiR7SGFTH5xB
 frNKUG/1AGqrs/leLnzErOiwv+inxg1ALlYhT7ddpOg3iz30m8Bgx6l3XR02zXjNZbmV
 cPNQ==
X-Gm-Message-State: APjAAAW8Jmdh7vw5R385I+sdZOFzYXLQW4Nd/OEJ0dxEdK6ORJgjFQ89
 HPgginkD4cfzIl9VxR2rYEk=
X-Google-Smtp-Source: APXvYqxWuXRncraTED2jeacoTPyN1fvtJGk3Zc52FbqH3XACtitgQolZjqrTP/UYKEopxq0KXI3bTw==
X-Received: by 2002:a63:480e:: with SMTP id v14mr1871131pga.182.1561500800857; 
 Tue, 25 Jun 2019 15:13:20 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
 by smtp.gmail.com with ESMTPSA id x3sm45355pja.7.2019.06.25.15.13.19
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 25 Jun 2019 15:13:19 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
 id D102E401EB; Tue, 25 Jun 2019 22:13:18 +0000 (UTC)
Date: Tue, 25 Jun 2019 22:13:18 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: Brendan Higgins <brendanhiggins@google.com>
Subject: Re: [PATCH v5 06/18] kbuild: enable building KUnit
Message-ID: <20190625221318.GO19023@42.do-not-panic.com>
References: <20190617082613.109131-1-brendanhiggins@google.com>
 <20190617082613.109131-7-brendanhiggins@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190617082613.109131-7-brendanhiggins@google.com>
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

On Mon, Jun 17, 2019 at 01:26:01AM -0700, Brendan Higgins wrote:
> diff --git a/Kconfig b/Kconfig
> index 48a80beab6853..10428501edb78 100644
> --- a/Kconfig
> +++ b/Kconfig
> @@ -30,3 +30,5 @@ source "crypto/Kconfig"
>  source "lib/Kconfig"
>  
>  source "lib/Kconfig.debug"
> +
> +source "kunit/Kconfig"

This patch would break compilation as kunit/Kconfig is not introduced. This
would would also break bisectability on this commit. This change should
either be folded in to the next patch, or just be a separate patch after
the next one.

  Luis
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
