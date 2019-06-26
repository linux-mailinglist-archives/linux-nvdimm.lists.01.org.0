Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 379BE55E36
	for <lists+linux-nvdimm@lfdr.de>; Wed, 26 Jun 2019 04:19:58 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9093321962301;
	Tue, 25 Jun 2019 19:19:56 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=209.85.210.196; helo=mail-pf1-f196.google.com;
 envelope-from=mcgrof@gmail.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com
 [209.85.210.196])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 26D9E21962301
 for <linux-nvdimm@lists.01.org>; Tue, 25 Jun 2019 19:19:55 -0700 (PDT)
Received: by mail-pf1-f196.google.com with SMTP id y15so430783pfn.5
 for <linux-nvdimm@lists.01.org>; Tue, 25 Jun 2019 19:19:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=ImbOmbqru+Yum9wVwWkpBNaUFJnZhA+Sv2EnuogBtJ8=;
 b=JZdFV0btQEA5KPtEQH/ZtNeJ420VaFpRRpDa/jdNnjuVW6OK1wh05RKUGS+LMs4//P
 Gg08FIDaOFeM1XFmjnYgBT6L0PoaKfp72gDouihpyGi7pOfWvr1lfjAdJT3DwU9tVE8m
 GTVa2z7AWPvWPzcOdOcWcej7Bkt8E1YYV7K7GdYOztdXVOUTwsiUfxGJU04IWqK55oGd
 PQZ9aRhb7kjS8YKUM5wO8IhS4zk92M3UNbN1bJO9mQbmc+YETG3hzF21To2q6lwWnUWx
 1+LDgIBB8davdeHcaIRpiy9gAH3rdEsFhsait6efX7jHrD2PJ0TuSDBk87RN9dJKadOn
 gbTQ==
X-Gm-Message-State: APjAAAVQSm+gI7i5NzhdiTzSrHW4gOforStDu98VJCZX+YR2tgKRujq3
 X0GITv62p12dUE5AHksxd2w=
X-Google-Smtp-Source: APXvYqz/ak3oqhDInPfCtSC5xTrl5WLmu4WvNmi0OnSYEvLdryLAAJJtmF40zvlfJnfwrjGTHOLxzA==
X-Received: by 2002:a17:90a:2486:: with SMTP id
 i6mr1267695pje.125.1561515594542; 
 Tue, 25 Jun 2019 19:19:54 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
 by smtp.gmail.com with ESMTPSA id q1sm23369013pfn.178.2019.06.25.19.19.53
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 25 Jun 2019 19:19:53 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
 id BB23740336; Wed, 26 Jun 2019 02:19:52 +0000 (UTC)
Date: Wed, 26 Jun 2019 02:19:52 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: Brendan Higgins <brendanhiggins@google.com>
Subject: Re: [PATCH v5 18/18] MAINTAINERS: add proc sysctl KUnit test to PROC
 SYSCTL section
Message-ID: <20190626021952.GV19023@42.do-not-panic.com>
References: <20190617082613.109131-1-brendanhiggins@google.com>
 <20190617082613.109131-19-brendanhiggins@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190617082613.109131-19-brendanhiggins@google.com>
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

On Mon, Jun 17, 2019 at 01:26:13AM -0700, Brendan Higgins wrote:
> Add entry for the new proc sysctl KUnit test to the PROC SYSCTL section.
> 
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

Acked-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
