Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C73B760CBD
	for <lists+linux-nvdimm@lfdr.de>; Fri,  5 Jul 2019 22:48:15 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6E1A3212B205C;
	Fri,  5 Jul 2019 13:48:14 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=209.85.210.196; helo=mail-pf1-f196.google.com;
 envelope-from=mcgrof@gmail.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com
 [209.85.210.196])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 2ABE6212AAB92
 for <linux-nvdimm@lists.01.org>; Fri,  5 Jul 2019 13:48:13 -0700 (PDT)
Received: by mail-pf1-f196.google.com with SMTP id q10so4759093pff.9
 for <linux-nvdimm@lists.01.org>; Fri, 05 Jul 2019 13:48:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=AcnoVRibB2N6fZ+Yp6hO160ET8GdPKrkYOq4kfDG3/o=;
 b=Sm1ghYKff+iQiqj1raldtB2Kdjh3gfq5Maug2deGyZkU2vAyX9EvBqGkDFS8y8+svB
 G4WQs5EmWme3zKhGnd0xOHy96qXc+GN2+YBl2sfDULsyE412mlfv7ZygEJaIs8YVpZgw
 FD5X00V7u033SlF11G1WgXinu75I5ShtrxUTitCVSN5JuHpzK/njOZWpfEej6d2xFaBZ
 Cp6Ch+1xasZgIluf645vPyW6m+MjPie7n5G9wuQCKO2qL1Fln8gBEKvW3WMJh1RoXp4T
 aZLasVPIrfLn+k1oXVzZlACH5FcVkla0oedgs/zSCmjD8D+UU1f9/aojgSb6VLGVqbHa
 vUfg==
X-Gm-Message-State: APjAAAUotdlhQn/2VoLNDpMoF9Eg0L/UCxnAqMCb1FvpXB+2SvwmFpcC
 Dhm2fxS30t/Z4/xvC2prKZc=
X-Google-Smtp-Source: APXvYqzYFkN68Owkq9koxWESGSYcLlSN0sO/MqwSKxCi7MUUXmOztl1dSndkrgfsbD0HEg9i6sStdg==
X-Received: by 2002:a63:6986:: with SMTP id e128mr7831367pgc.220.1562359692276; 
 Fri, 05 Jul 2019 13:48:12 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
 by smtp.gmail.com with ESMTPSA id p7sm13219309pfp.131.2019.07.05.13.48.10
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 05 Jul 2019 13:48:11 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
 id 568B940190; Fri,  5 Jul 2019 20:48:10 +0000 (UTC)
Date: Fri, 5 Jul 2019 20:48:10 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: Brendan Higgins <brendanhiggins@google.com>
Subject: Re: [PATCH v6 18/18] MAINTAINERS: add proc sysctl KUnit test to PROC
 SYSCTL section
Message-ID: <20190705204810.GE19023@42.do-not-panic.com>
References: <20190704003615.204860-1-brendanhiggins@google.com>
 <20190704003615.204860-19-brendanhiggins@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190704003615.204860-19-brendanhiggins@google.com>
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

On Wed, Jul 03, 2019 at 05:36:15PM -0700, Brendan Higgins wrote:
> Add entry for the new proc sysctl KUnit test to the PROC SYSCTL section.
> 
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> Acked-by: Luis Chamberlain <mcgrof@kernel.org>

Come to think of it, I'd welcome Iurii to be added as a maintainer,
with the hope Iurii would be up to review only the kunit changes. Of
course if Iurii would be up to also help review future proc changes,
even better. 3 pair of eyeballs is better than 2 pairs.

  Luis
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
