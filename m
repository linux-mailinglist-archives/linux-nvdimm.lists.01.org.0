Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF4462C72
	for <lists+linux-nvdimm@lfdr.de>; Tue,  9 Jul 2019 01:16:05 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2865D212ACEC0;
	Mon,  8 Jul 2019 16:16:04 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::644; helo=mail-pl1-x644.google.com;
 envelope-from=brendanhiggins@google.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20::644])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 4FE5B212AB4E0
 for <linux-nvdimm@lists.01.org>; Mon,  8 Jul 2019 16:16:02 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id k8so9056699plt.3
 for <linux-nvdimm@lists.01.org>; Mon, 08 Jul 2019 16:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=oGZm1g5vtwwYit0yoo3SBX6Ei/KDlijim8AwfezWq5Q=;
 b=lFUSTt8nxcpQ1geusJZ3lspP7XQwyYNu3KMayNoosCV6UA30ZuMzOWUPZfCjTUzeKM
 iYW2yITMtWXzol7/+legnfgPOBGwjXoEFw7yce+7btcdg0htf2Hg4YfxND5u9apalxJL
 B3QYi+HDYUWlIIkNVozIYrBRfW/Zk/Qz4dosV0rI2mUxb16C62VVRSPlRILHQVx/6UE4
 RshFiQlSNd9CkGW5eoiTTfauBDsWytWT+kOLzVSwNCWkeJDN/HkdAIqfFvOi2TKYEg+r
 l8O7ss1ZZdrzfcN3z+0quxvvwbfum43KpVYwwtrEJTbglIXZty13qrEB3TCpWKeCVLSU
 fZ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=oGZm1g5vtwwYit0yoo3SBX6Ei/KDlijim8AwfezWq5Q=;
 b=AuXp9cfUWb0Ok2GXeYnGnolyNsWC3HcSokFWgtxcx48d4RizwlgxUUrC0eWCaiTwq/
 uYuHst+hulFggzMxbxyNtM5SUs5QCBJoHAbFQlkD1HHVMwMc+C2gxJYLhL7YsppaJLKt
 EGd7mZpzn6j2XhkQtpacBCd0RinyW1OS6kLtQcSFSMMavqHW67iF9j2cCs8/wKWtp/Hk
 rKN8bHgyVtx7uXO8Np++/9JOX2M87N/4tM7ETOwFgjjIGi3jjYPCl33tXPzcb2Ktp82r
 snqMWJ00lm5zoN8PqSwmBOUrccwbUb33oeJJwJHp3KVKn7J7AC4kg3MuIVSn/eC+eyAV
 Cw9g==
X-Gm-Message-State: APjAAAWC4q7C3iLBSDa9SWMiy1D+Bf6D5kaLa9C6TTzqWmQVaTQcSxTx
 /VcfWjQ+J8pKjky0m1pJSoPyIJqS0u23AKpET4X2Hw==
X-Google-Smtp-Source: APXvYqxLj9lV04W3pazbpY/qgg7ti1gSJwsPPAdwKpyGKBI70/LFOjfevFPZPMucLfnGO+AW10E2yFZhfTdlozEZOjY=
X-Received: by 2002:a17:902:29e6:: with SMTP id
 h93mr26754760plb.297.1562627761245; 
 Mon, 08 Jul 2019 16:16:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190704003615.204860-1-brendanhiggins@google.com>
 <20190704003615.204860-19-brendanhiggins@google.com>
 <20190705204810.GE19023@42.do-not-panic.com>
In-Reply-To: <20190705204810.GE19023@42.do-not-panic.com>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Mon, 8 Jul 2019 16:15:49 -0700
Message-ID: <CAFd5g44j7ECQorYLnDQadAaj+yBki98kFjmjejn+3W4eHtqGDA@mail.gmail.com>
Subject: Re: [PATCH v6 18/18] MAINTAINERS: add proc sysctl KUnit test to PROC
 SYSCTL section
To: Luis Chamberlain <mcgrof@kernel.org>, Iurii Zaikin <yzaikin@google.com>
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
Cc: Petr Mladek <pmladek@suse.com>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Amir Goldstein <amir73il@gmail.com>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Sasha Levin <Alexander.Levin@microsoft.com>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 shuah <shuah@kernel.org>, Rob Herring <robh@kernel.org>,
 linux-nvdimm <linux-nvdimm@lists.01.org>,
 Frank Rowand <frowand.list@gmail.com>, Knut Omang <knut.omang@oracle.com>,
 Kieran Bingham <kieran.bingham@ideasonboard.com>, wfg@linux.intel.com,
 Joel Stanley <joel@jms.id.au>, David Rientjes <rientjes@google.com>,
 Jeff Dike <jdike@addtoit.com>, Dan Carpenter <dan.carpenter@oracle.com>,
 devicetree <devicetree@vger.kernel.org>,
 linux-kbuild <linux-kbuild@vger.kernel.org>, "Bird,
 Timothy" <Tim.Bird@sony.com>, linux-um@lists.infradead.org,
 Steven Rostedt <rostedt@goodmis.org>, Julia Lawall <julia.lawall@lip6.fr>,
 Josh Poimboeuf <jpoimboe@redhat.com>, kunit-dev@googlegroups.com,
 Theodore Ts'o <tytso@mit.edu>, Richard Weinberger <richard@nod.at>,
 Stephen Boyd <sboyd@kernel.org>, Greg KH <gregkh@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Daniel Vetter <daniel@ffwll.ch>, Kees Cook <keescook@google.com>,
 linux-fsdevel@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

CC'ing Iurii Zaikin

On Fri, Jul 5, 2019 at 1:48 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Wed, Jul 03, 2019 at 05:36:15PM -0700, Brendan Higgins wrote:
> > Add entry for the new proc sysctl KUnit test to the PROC SYSCTL section.
> >
> > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> > Acked-by: Luis Chamberlain <mcgrof@kernel.org>
>
> Come to think of it, I'd welcome Iurii to be added as a maintainer,
> with the hope Iurii would be up to review only the kunit changes. Of
> course if Iurii would be up to also help review future proc changes,
> even better. 3 pair of eyeballs is better than 2 pairs.

What do you think, Iurii?
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
