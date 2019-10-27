Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D6AE6089
	for <lists+linux-nvdimm@lfdr.de>; Sun, 27 Oct 2019 06:18:05 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7DD7B100EA60A;
	Sat, 26 Oct 2019 22:19:04 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.65; helo=mga03.intel.com; envelope-from=rong.a.chen@intel.com; receiver=<UNKNOWN> 
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 8B05E100EA609;
	Sat, 26 Oct 2019 22:19:01 -0700 (PDT)
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Oct 2019 22:17:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,234,1569308400";
   d="yaml'?scan'208";a="350389555"
Received: from shao2-debian.sh.intel.com (HELO localhost) ([10.239.13.6])
  by orsmga004.jf.intel.com with ESMTP; 26 Oct 2019 22:17:54 -0700
Date: Sun, 27 Oct 2019 13:17:42 +0800
From: kernel test robot <rong.a.chen@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: [fs/dax]  a70e8083a9:  fio.read_bw_MBps 523.2% improvement
Message-ID: <20191027051742.GI29418@shao2-debian>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="GBuTPvBEOL0MYPgd"
Content-Disposition: inline
In-Reply-To: <157167532455.3945484.11971474077040503994.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Content-Transfer-Encoding: 7bit
Message-ID-Hash: ED2QRIPGV2VOFVQLB4AEAPCFK4HAGTHI
X-Message-ID-Hash: ED2QRIPGV2VOFVQLB4AEAPCFK4HAGTHI
X-MailFrom: rong.a.chen@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-fsdevel@vger.kernel.org, Jeff Smits <jeff.smits@intel.com>, Doug Nelson <doug.nelson@intel.com>, stable@vger.kernel.org, Jan Kara <jack@suse.cz>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, lkp@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ED2QRIPGV2VOFVQLB4AEAPCFK4HAGTHI/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>


--GBuTPvBEOL0MYPgd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Greeting,

FYI, we noticed a 523.2% improvement of fio.read_bw_MBps due to commit:


commit: a70e8083a91b17a7c77012f7746dbf29b5050e66 ("[PATCH v2] fs/dax: Fix=
 pmd vs pte conflict detection")
url: https://github.com/0day-ci/linux/commits/Dan-Williams/fs-dax-Fix-pmd=
-vs-pte-conflict-detection/20191022-045925


in testcase: fio-basic
on test machine: 96 threads Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz with=
 256G memory
with following parameters:

	disk: 2pmem
	fs: ext4
	mount_option: dax
	runtime: 200s
	nr_task: 50%
	time_based: tb
	rw: rw
	bs: 4k
	ioengine: mmap
	test_size: 200G
	ucode: 0x5000021
	cpufreq_governor: performance

test-description: Fio is a tool that will spawn a number of threads or pr=
ocesses doing a particular type of I/O action as specified by the user.
test-url: https://github.com/axboe/fio

In addition to that, the commit also has significant impact on the follow=
ing tests:

+------------------+-----------------------------------------------------=
-----------------+
| testcase: change | fio-basic: fio.write_bw_MBps 363.7% improvement     =
                 |
| test machine     | 96 threads Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz =
with 256G memory |
| test parameters  | bs=3D2M                                             =
                   |
|                  | cpufreq_governor=3Dperformance                      =
                   |
|                  | disk=3D2pmem                                        =
                   |
|                  | fs=3Dext4                                           =
                   |
|                  | ioengine=3Dmmap                                     =
                   |
|                  | mount_option=3Ddax                                  =
                   |
|                  | nr_task=3D50%                                       =
                   |
|                  | runtime=3D200s                                      =
                   |
|                  | rw=3Dwrite                                          =
                   |
|                  | test_size=3D200G                                    =
                   |
|                  | time_based=3Dtb                                     =
                   |
|                  | ucode=3D0x5000021                                   =
                   |
+------------------+-----------------------------------------------------=
-----------------+




Details are as below:
-------------------------------------------------------------------------=
------------------------->


To reproduce:

        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        bin/lkp install job.yaml  # job file is attached in this email
        bin/lkp run     job.yaml

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
bs/compiler/cpufreq_governor/disk/fs/ioengine/kconfig/mount_option/nr_tas=
k/rootfs/runtime/rw/tbox_group/test_size/testcase/time_based/ucode:
  4k/gcc-7/performance/2pmem/ext4/mmap/x86_64-rhel-7.6/dax/50%/debian-x86=
_64-2019-05-14.cgz/200s/rw/lkp-csl-2sp6/200G/fio-basic/tb/0x5000021

commit:=20
  v5.4-rc4
  a70e8083a9 ("fs/dax: Fix pmd vs pte conflict detection")

        v5.4-rc4 a70e8083a91b17a7c77012f7746=20
---------------- ---------------------------=20
       fail:runs  %reproduction    fail:runs
           |             |             |   =20
          1:5          -19%           0:4     perf-profile.children.cycle=
s-pp.error_entry
         %stddev     %change         %stddev
             \          |                \ =20
      0.04 =C2=B1103%      -0.0        0.01        fio.latency_100us%
      0.40 =C2=B1 17%      +0.7        1.09 =C2=B1 11%  fio.latency_10us%
     42.23 =C2=B1  3%     -42.0        0.24 =C2=B1 30%  fio.latency_20us%
      0.04 =C2=B1 48%     +58.8       58.84 =C2=B1  7%  fio.latency_2us%
      0.03 =C2=B1 36%     +25.4       25.47 =C2=B1 21%  fio.latency_4us%
     26.56 =C2=B1  5%     -26.3        0.24 =C2=B1 13%  fio.latency_50us%
      6660          +523.2%      41507 =C2=B1  4%  fio.read_bw_MBps
     19072           -86.6%       2560 =C2=B1  4%  fio.read_clat_90%_us
     19993           -85.8%       2840 =C2=B1  4%  fio.read_clat_95%_us
     23475           -79.6%       4784 =C2=B1  4%  fio.read_clat_99%_us
      7134           -73.5%       1892 =C2=B1  5%  fio.read_clat_mean_us
     11158 =C2=B1 17%     -84.4%       1738 =C2=B1  6%  fio.read_clat_std=
dev
   1704992          +523.2%   10625819 =C2=B1  4%  fio.read_iops
    227.61            -7.6%     210.23        fio.time.elapsed_time
    227.61            -7.6%     210.23        fio.time.elapsed_time.max
 4.724e+08           -85.0%   70736715 =C2=B1  3%  fio.time.minor_page_fa=
ults
      4224            +8.3%       4573        fio.time.percent_of_cpu_thi=
s_job_got
      8989           -96.8%     288.96 =C2=B1  4%  fio.time.system_time
    626.08 =C2=B1  2%   +1389.9%       9327        fio.time.user_time
     23802            -9.7%      21483        fio.time.voluntary_context_=
switches
 6.821e+08          +523.1%  4.251e+09 =C2=B1  4%  fio.workload
      6662          +523.1%      41513 =C2=B1  4%  fio.write_bw_MBps
     23526           -90.9%       2150 =C2=B1  3%  fio.write_clat_90%_us
     25779           -90.5%       2448 =C2=B1  4%  fio.write_clat_95%_us
     32665 =C2=B1  6%     -83.9%       5248 =C2=B1  5%  fio.write_clat_99=
%_us
     20398           -92.1%       1612 =C2=B1  3%  fio.write_clat_mean_us
      9815 =C2=B1 15%     -76.4%       2315 =C2=B1  8%  fio.write_clat_st=
ddev
   1705684          +523.1%   10627503 =C2=B1  4%  fio.write_iops
     40917 =C2=B1 70%     -77.1%       9387 =C2=B1 57%  cpuidle.POLL.usag=
e
     41.15           -39.5        1.63 =C2=B1  4%  mpstat.cpu.all.sys%
      2.87 =C2=B1  2%     +43.9       46.79        mpstat.cpu.all.usr%
     56.36            -7.7%      52.03        iostat.cpu.idle
     40.80           -96.0%       1.62 =C2=B1  4%  iostat.cpu.system
      2.85 =C2=B1  2%   +1528.8%      46.35        iostat.cpu.user
     56.00            -7.1%      52.00        vmstat.cpu.id
      2.00         +2200.0%      46.00        vmstat.cpu.us
   2143726           -19.7%    1720555        vmstat.memory.cache
   1156106 =C2=B1 19%     -65.7%     396915 =C2=B1 49%  numa-numastat.nod=
e0.local_node
   1162440 =C2=B1 17%     -64.5%     412613 =C2=B1 44%  numa-numastat.nod=
e0.numa_hit
      6344 =C2=B1193%    +147.5%      15702 =C2=B1 98%  numa-numastat.nod=
e0.other_node
    916775 =C2=B1 23%     -55.2%     410953 =C2=B1 48%  numa-numastat.nod=
e1.local_node
    941710 =C2=B1 21%     -54.7%     426566 =C2=B1 43%  numa-numastat.nod=
e1.numa_hit
    498777           -80.2%      98859        meminfo.KReclaimable
   7644983           -18.7%    6215641        meminfo.Memused
   1178141           -87.3%     149626 =C2=B1  3%  meminfo.PageTables
    498777           -80.2%      98859        meminfo.SReclaimable
    681978           -58.1%     285710        meminfo.Slab
     40679           -23.8%      30984        meminfo.max_used_kB
      1246           +10.7%       1379        turbostat.Avg_MHz
     44.75            +4.7       49.43        turbostat.Busy%
     56.00           +11.2%      62.25        turbostat.CoreTmp
     56.20           +10.3%      62.00        turbostat.PkgTmp
    245.28           +18.0%     289.40        turbostat.PkgWatt
    128.78           +45.3%     187.11        turbostat.RAMWatt
      4275 =C2=B1 14%   +1135.7%      52830 =C2=B1 90%  numa-vmstat.node0=
.nr_mapped
    142255 =C2=B1  5%     -86.4%      19293 =C2=B1 49%  numa-vmstat.node0=
.nr_page_table_pages
     52355 =C2=B1 21%     -74.2%      13489 =C2=B1 13%  numa-vmstat.node0=
.nr_slab_reclaimable
   1367388 =C2=B1 23%     -32.4%     924713 =C2=B1 22%  numa-vmstat.node0=
.numa_hit
   1360094 =C2=B1 23%     -33.2%     908947 =C2=B1 22%  numa-vmstat.node0=
.numa_local
    150783 =C2=B1  7%     -88.0%      18133 =C2=B1 58%  numa-vmstat.node1=
.nr_page_table_pages
     72319 =C2=B1 16%     -84.5%      11218 =C2=B1 17%  numa-vmstat.node1=
.nr_slab_reclaimable
    738.20 =C2=B1  8%     +13.8%     840.00 =C2=B1  5%  slabinfo.blkdev_i=
oc.num_objs
      1699 =C2=B1  8%     -44.5%     942.75 =C2=B1  8%  slabinfo.dquot.ac=
tive_objs
      1699 =C2=B1  8%     -44.5%     942.75 =C2=B1  8%  slabinfo.dquot.nu=
m_objs
    760144           -92.4%      57717        slabinfo.radix_tree_node.ac=
tive_objs
     13576           -92.4%       1031        slabinfo.radix_tree_node.ac=
tive_slabs
    760334           -92.4%      57771        slabinfo.radix_tree_node.nu=
m_objs
     13576           -92.4%       1031        slabinfo.radix_tree_node.nu=
m_slabs
    560.40 =C2=B1  7%     +14.2%     640.25 =C2=B1  3%  slabinfo.skbuff_e=
xt_cache.active_objs
    209548 =C2=B1 21%     -74.2%      53962 =C2=B1 13%  numa-meminfo.node=
0.KReclaimable
     17189 =C2=B1 13%   +1129.1%     211277 =C2=B1 90%  numa-meminfo.node=
0.Mapped
   3707244 =C2=B1  4%     -13.1%    3221190 =C2=B1  3%  numa-meminfo.node=
0.MemUsed
    572232 =C2=B1  5%     -86.5%      77122 =C2=B1 49%  numa-meminfo.node=
0.PageTables
    209548 =C2=B1 21%     -74.2%      53962 =C2=B1 13%  numa-meminfo.node=
0.SReclaimable
    308536 =C2=B1 16%     -48.4%     159181 =C2=B1  7%  numa-meminfo.node=
0.Slab
    289299 =C2=B1 15%     -84.5%      44861 =C2=B1 17%  numa-meminfo.node=
1.KReclaimable
   3939263 =C2=B1  3%     -24.0%    2994130 =C2=B1  4%  numa-meminfo.node=
1.MemUsed
    606602 =C2=B1  7%     -88.0%      72494 =C2=B1 58%  numa-meminfo.node=
1.PageTables
    289299 =C2=B1 15%     -84.5%      44861 =C2=B1 17%  numa-meminfo.node=
1.SReclaimable
    373513 =C2=B1 13%     -66.1%     126490 =C2=B1  9%  numa-meminfo.node=
1.Slab
      5108            +4.4%       5331 =C2=B1  2%  proc-vmstat.nr_active_=
file
     64785            +1.3%      65642        proc-vmstat.nr_anon_pages
     86.00 =C2=B1 13%     +41.6%     121.75 =C2=B1 28%  proc-vmstat.nr_di=
rtied
   1028576            +3.4%    1064023        proc-vmstat.nr_dirty_backgr=
ound_threshold
   2059669            +3.4%    2130649        proc-vmstat.nr_dirty_thresh=
old
  10368676            +3.4%   10723419        proc-vmstat.nr_free_pages
     95519            +8.2%     103375        proc-vmstat.nr_inactive_ano=
n
     84.00 =C2=B1  2%     +25.6%     105.50 =C2=B1 11%  proc-vmstat.nr_in=
active_file
     96766            +8.7%     105168        proc-vmstat.nr_mapped
    292164           -87.2%      37319 =C2=B1  3%  proc-vmstat.nr_page_ta=
ble_pages
    124646           -80.2%      24716        proc-vmstat.nr_slab_reclaim=
able
     45797            +2.0%      46711        proc-vmstat.nr_slab_unrecla=
imable
      5108            +4.4%       5331 =C2=B1  2%  proc-vmstat.nr_zone_ac=
tive_file
     95519            +8.2%     103375        proc-vmstat.nr_zone_inactiv=
e_anon
     84.00 =C2=B1  2%     +25.6%     105.50 =C2=B1 11%  proc-vmstat.nr_zo=
ne_inactive_file
   2127714           -59.4%     864384        proc-vmstat.numa_hit
   2096428           -60.3%     833061        proc-vmstat.numa_local
      3112 =C2=B1  7%     +16.8%       3637 =C2=B1  9%  proc-vmstat.numa_=
pte_updates
   2268500           -60.9%     886227        proc-vmstat.pgalloc_normal
 4.731e+08           -84.9%   71307545 =C2=B1  3%  proc-vmstat.pgfault
   2172870           -62.9%     806246        proc-vmstat.pgfree
    666825           -88.8%      74786 =C2=B1  3%  proc-vmstat.thp_fault_=
fallback
    129.10 =C2=B1  4%    +134.2%     302.32 =C2=B1 13%  sched_debug.cfs_r=
q:/.exec_clock.min
    792591           +49.3%    1183484 =C2=B1 10%  sched_debug.cfs_rq:/.l=
oad.max
    343702 =C2=B1  3%     +16.1%     399036 =C2=B1  2%  sched_debug.cfs_r=
q:/.load.stddev
      1.00           +31.2%       1.31 =C2=B1  8%  sched_debug.cfs_rq:/.n=
r_running.max
      0.40 =C2=B1  2%      +9.3%       0.44        sched_debug.cfs_rq:/.n=
r_running.stddev
    791828           +49.5%    1183484 =C2=B1 10%  sched_debug.cfs_rq:/.r=
unnable_weight.max
    343573 =C2=B1  3%     +16.1%     399045 =C2=B1  2%  sched_debug.cfs_r=
q:/.runnable_weight.stddev
    549.67 =C2=B1  4%     -38.6%     337.58 =C2=B1  5%  sched_debug.cfs_r=
q:/.util_est_enqueued.avg
    597408           +36.4%     814808        sched_debug.cpu.avg_idle.av=
g
    365969           -38.5%     225103 =C2=B1  2%  sched_debug.cpu.avg_id=
le.stddev
      2.73 =C2=B1  4%    +236.1%       9.18 =C2=B1 14%  sched_debug.cpu.c=
lock.stddev
      2.73 =C2=B1  4%    +236.1%       9.18 =C2=B1 14%  sched_debug.cpu.c=
lock_task.stddev
      1.00           +31.2%       1.31 =C2=B1  8%  sched_debug.cpu.nr_run=
ning.max
     19380 =C2=B1 22%     +78.8%      34650 =C2=B1 35%  sched_debug.cpu.n=
r_switches.max
     14002 =C2=B1 23%     +95.1%      27315 =C2=B1 33%  sched_debug.cpu.s=
ched_count.max
      2363 =C2=B1 15%     +40.3%       3316 =C2=B1 23%  sched_debug.cpu.s=
ched_count.stddev
      6961 =C2=B1 23%     +95.7%      13623 =C2=B1 34%  sched_debug.cpu.s=
ched_goidle.max
     23.40 =C2=B1  3%     -71.7%       6.62 =C2=B1 13%  sched_debug.cpu.s=
ched_goidle.min
      1191 =C2=B1 14%     +39.6%       1663 =C2=B1 23%  sched_debug.cpu.s=
ched_goidle.stddev
     51.70 =C2=B1  4%     +51.0%      78.06 =C2=B1 24%  sched_debug.cpu.t=
twu_count.min
    441.41           -12.4%     386.45 =C2=B1  2%  sched_debug.cpu.ttwu_l=
ocal.avg
     30.50 =C2=B1  4%     +28.1%      39.06 =C2=B1 17%  sched_debug.cpu.t=
twu_local.min
    193.20 =C2=B1  2%      -8.1%     177.50 =C2=B1  3%  interrupts.37:PCI=
-MSI.31981568-edge.i40e-0000:3d:00.0:misc
      0.00       +6.6e+103%      66.25 =C2=B1159%  interrupts.88:PCI-MSI.=
31981619-edge.i40e-eth0-TxRx-50
     24.20 =C2=B1183%   +3928.9%     975.00 =C2=B1126%  interrupts.CPU10.=
RES:Rescheduling_interrupts
     22.00 =C2=B1130%    +284.1%      84.50 =C2=B1 59%  interrupts.CPU12.=
RES:Rescheduling_interrupts
    162.60 =C2=B1113%    +408.8%     827.25 =C2=B1 98%  interrupts.CPU2.R=
ES:Rescheduling_interrupts
     10.40 =C2=B1143%   +1779.8%     195.50 =C2=B1 84%  interrupts.CPU26.=
RES:Rescheduling_interrupts
      4.40 =C2=B1 51%   +3985.2%     179.75 =C2=B1107%  interrupts.CPU27.=
RES:Rescheduling_interrupts
     84.00 =C2=B1180%   +7481.5%       6368 =C2=B1163%  interrupts.CPU30.=
RES:Rescheduling_interrupts
     81.80 =C2=B1172%    +368.2%     383.00 =C2=B1 98%  interrupts.CPU31.=
RES:Rescheduling_interrupts
      2.40 =C2=B1 62%   +6097.9%     148.75 =C2=B1145%  interrupts.CPU32.=
RES:Rescheduling_interrupts
      3.20 =C2=B1 93%   +4689.1%     153.25 =C2=B1111%  interrupts.CPU33.=
RES:Rescheduling_interrupts
      2840 =C2=B1 12%     -18.2%       2324 =C2=B1  5%  interrupts.CPU35.=
CAL:Function_call_interrupts
      4.00 =C2=B1 54%  +14525.0%     585.00 =C2=B1158%  interrupts.CPU38.=
RES:Rescheduling_interrupts
      2.20 =C2=B1 66%   +2422.7%      55.50 =C2=B1 56%  interrupts.CPU39.=
RES:Rescheduling_interrupts
      2.40 =C2=B1 97%   +7660.4%     186.25 =C2=B1133%  interrupts.CPU42.=
RES:Rescheduling_interrupts
      3.20 =C2=B1 66%   +1642.2%      55.75 =C2=B1 88%  interrupts.CPU44.=
RES:Rescheduling_interrupts
      2.20 =C2=B1109%   +4604.5%     103.50 =C2=B1102%  interrupts.CPU45.=
RES:Rescheduling_interrupts
      0.00       +6.6e+103%      66.00 =C2=B1160%  interrupts.CPU50.88:PC=
I-MSI.31981619-edge.i40e-eth0-TxRx-50
     11.60 =C2=B1 82%    +684.5%      91.00 =C2=B1 65%  interrupts.CPU50.=
RES:Rescheduling_interrupts
      6.20 =C2=B1 73%   +1545.2%     102.00 =C2=B1104%  interrupts.CPU51.=
RES:Rescheduling_interrupts
      9.20 =C2=B1 67%   +1416.3%     139.50 =C2=B1 61%  interrupts.CPU54.=
RES:Rescheduling_interrupts
     13.00 =C2=B1 27%    +503.8%      78.50 =C2=B1 73%  interrupts.CPU55.=
RES:Rescheduling_interrupts
      7.60 =C2=B1 62%    +962.5%      80.75 =C2=B1 83%  interrupts.CPU56.=
RES:Rescheduling_interrupts
     14.80 =C2=B1141%    +416.9%      76.50 =C2=B1 41%  interrupts.CPU57.=
RES:Rescheduling_interrupts
      8.20 =C2=B1 56%   +1445.7%     126.75 =C2=B1 88%  interrupts.CPU60.=
RES:Rescheduling_interrupts
      9.40 =C2=B1 63%    +817.6%      86.25 =C2=B1 28%  interrupts.CPU61.=
RES:Rescheduling_interrupts
     14.80 =C2=B1 83%    +513.2%      90.75 =C2=B1 32%  interrupts.CPU62.=
RES:Rescheduling_interrupts
      5.60 =C2=B1 96%   +1400.0%      84.00 =C2=B1 51%  interrupts.CPU63.=
RES:Rescheduling_interrupts
      8.20 =C2=B1 64%    +750.6%      69.75 =C2=B1 33%  interrupts.CPU65.=
RES:Rescheduling_interrupts
     10.20 =C2=B1 50%    +581.4%      69.50 =C2=B1 28%  interrupts.CPU68.=
RES:Rescheduling_interrupts
     36.60 =C2=B1 50%    +150.0%      91.50 =C2=B1 69%  interrupts.CPU70.=
TLB:TLB_shootdowns
      8.60 =C2=B1136%    +594.8%      59.75 =C2=B1 51%  interrupts.CPU76.=
RES:Rescheduling_interrupts
      3.60 =C2=B1132%   +1497.2%      57.50 =C2=B1 73%  interrupts.CPU78.=
RES:Rescheduling_interrupts
      7.80 =C2=B1 98%   +1582.7%     131.25 =C2=B1 91%  interrupts.CPU8.R=
ES:Rescheduling_interrupts
     17.40 =C2=B1 80%    +293.7%      68.50 =C2=B1 60%  interrupts.CPU8.T=
LB:TLB_shootdowns
    193.20 =C2=B1  2%      -8.1%     177.50 =C2=B1  3%  interrupts.CPU9.3=
7:PCI-MSI.31981568-edge.i40e-0000:3d:00.0:misc
     14.71 =C2=B1  3%     +81.5%      26.70        perf-stat.i.MPKI
 5.704e+09           +69.4%  9.665e+09 =C2=B1  4%  perf-stat.i.branch-ins=
tructions
      0.45 =C2=B1  8%      +0.1        0.54 =C2=B1  4%  perf-stat.i.branc=
h-miss-rate%
  23774744 =C2=B1  2%    +111.4%   50251745 =C2=B1  3%  perf-stat.i.branc=
h-misses
     54.74           +26.7       81.45        perf-stat.i.cache-miss-rate=
%
 2.382e+08 =C2=B1  3%    +367.4%  1.113e+09 =C2=B1  4%  perf-stat.i.cache=
-misses
 4.015e+08 =C2=B1  2%    +229.1%  1.321e+09 =C2=B1  4%  perf-stat.i.cache=
-references
      4.39           -39.4%       2.66 =C2=B1  4%  perf-stat.i.cpi
 1.195e+11            +8.0%  1.291e+11        perf-stat.i.cpu-cycles
    896.52 =C2=B1  7%     -66.4%     301.06 =C2=B1 17%  perf-stat.i.cycle=
s-between-cache-misses
      0.05 =C2=B1 12%      -0.0        0.01 =C2=B1 52%  perf-stat.i.dTLB-=
load-miss-rate%
   3096297           -78.6%     663585 =C2=B1  3%  perf-stat.i.dTLB-load-=
misses
   6.8e+09           +97.8%  1.345e+10 =C2=B1  5%  perf-stat.i.dTLB-loads
      0.24 =C2=B1 11%      -0.2        0.01 =C2=B1  7%  perf-stat.i.dTLB-=
store-miss-rate%
   7425754 =C2=B1 11%     -88.6%     844034 =C2=B1  3%  perf-stat.i.dTLB-=
store-misses
 2.807e+09          +185.8%  8.022e+09 =C2=B1  4%  perf-stat.i.dTLB-store=
s
     68.54           -30.1       38.46 =C2=B1  5%  perf-stat.i.iTLB-load-=
miss-rate%
  12855481 =C2=B1  3%     -75.9%    3100419 =C2=B1  4%  perf-stat.i.iTLB-=
load-misses
 2.552e+10           +89.4%  4.834e+10 =C2=B1  4%  perf-stat.i.instructio=
ns
      2195 =C2=B1  3%    +618.7%      15776 =C2=B1  8%  perf-stat.i.instr=
uctions-per-iTLB-miss
      0.27 =C2=B1  4%     +41.6%       0.38 =C2=B1  4%  perf-stat.i.ipc
   2077653           -83.5%     342553 =C2=B1  3%  perf-stat.i.minor-faul=
ts
  31404609 =C2=B1 27%    +545.5%  2.027e+08 =C2=B1 22%  perf-stat.i.node-=
load-misses
  32711606 =C2=B1 20%    +625.0%  2.372e+08 =C2=B1 26%  perf-stat.i.node-=
loads
  26979202 =C2=B1 24%    +446.5%  1.474e+08 =C2=B1 18%  perf-stat.i.node-=
store-misses
  25469597 =C2=B1 22%    +515.9%  1.569e+08 =C2=B1 22%  perf-stat.i.node-=
stores
   2077670           -83.5%     342558 =C2=B1  3%  perf-stat.i.page-fault=
s
     15.73 =C2=B1  2%     +73.7%      27.33        perf-stat.overall.MPKI
      0.42 =C2=B1  2%      +0.1        0.52        perf-stat.overall.bran=
ch-miss-rate%
     59.33           +24.9       84.27        perf-stat.overall.cache-mis=
s-rate%
      4.68           -42.8%       2.68 =C2=B1  4%  perf-stat.overall.cpi
    501.88 =C2=B1  2%     -76.9%     116.15 =C2=B1  4%  perf-stat.overall=
.cycles-between-cache-misses
      0.05            -0.0        0.00 =C2=B1  5%  perf-stat.overall.dTLB=
-load-miss-rate%
      0.26 =C2=B1 11%      -0.3        0.01 =C2=B1  4%  perf-stat.overall=
.dTLB-store-miss-rate%
     70.67           -32.5       38.22 =C2=B1  6%  perf-stat.overall.iTLB=
-load-miss-rate%
      1988 =C2=B1  4%    +686.7%      15642 =C2=B1  7%  perf-stat.overall=
.instructions-per-iTLB-miss
      0.21           +75.3%       0.37 =C2=B1  4%  perf-stat.overall.ipc
      8446           -72.1%       2357        perf-stat.overall.path-leng=
th
 5.679e+09           +69.4%  9.622e+09 =C2=B1  4%  perf-stat.ps.branch-in=
structions
  23670395 =C2=B1  2%    +111.4%   50029998 =C2=B1  3%  perf-stat.ps.bran=
ch-misses
 2.372e+08 =C2=B1  3%    +367.4%  1.109e+09 =C2=B1  4%  perf-stat.ps.cach=
e-misses
 3.998e+08 =C2=B1  2%    +229.1%  1.316e+09 =C2=B1  4%  perf-stat.ps.cach=
e-references
 1.189e+11            +8.1%  1.285e+11        perf-stat.ps.cpu-cycles
   3082720           -78.6%     660373 =C2=B1  3%  perf-stat.ps.dTLB-load=
-misses
  6.77e+09           +97.8%  1.339e+10 =C2=B1  5%  perf-stat.ps.dTLB-load=
s
   7393213 =C2=B1 11%     -88.6%     840338 =C2=B1  3%  perf-stat.ps.dTLB=
-store-misses
 2.795e+09          +185.8%  7.987e+09 =C2=B1  4%  perf-stat.ps.dTLB-stor=
es
  12799067 =C2=B1  3%     -75.9%    3086339 =C2=B1  4%  perf-stat.ps.iTLB=
-load-misses
 2.541e+10           +89.4%  4.813e+10 =C2=B1  4%  perf-stat.ps.instructi=
ons
   2068549           -83.5%     341065 =C2=B1  3%  perf-stat.ps.minor-fau=
lts
  31266968 =C2=B1 27%    +545.7%  2.019e+08 =C2=B1 22%  perf-stat.ps.node=
-load-misses
  32567992 =C2=B1 20%    +625.0%  2.361e+08 =C2=B1 26%  perf-stat.ps.node=
-loads
  26860938 =C2=B1 24%    +446.6%  1.468e+08 =C2=B1 18%  perf-stat.ps.node=
-store-misses
  25357836 =C2=B1 22%    +515.9%  1.562e+08 =C2=B1 22%  perf-stat.ps.node=
-stores
   2068565           -83.5%     341071 =C2=B1  3%  perf-stat.ps.page-faul=
ts
 5.762e+12           +73.9%  1.002e+13 =C2=B1  4%  perf-stat.total.instru=
ctions
      7535 =C2=B1 26%    +516.5%      46458 =C2=B1 13%  softirqs.CPU0.RCU
      6126 =C2=B1  2%    +575.9%      41409 =C2=B1 15%  softirqs.CPU1.RCU
      6381 =C2=B1  7%    +611.1%      45378 =C2=B1 12%  softirqs.CPU10.RC=
U
      6087 =C2=B1  5%    +641.3%      45123 =C2=B1  9%  softirqs.CPU11.RC=
U
      6287 =C2=B1  2%    +619.4%      45231 =C2=B1  8%  softirqs.CPU12.RC=
U
      7342 =C2=B1 23%    +521.9%      45667 =C2=B1 10%  softirqs.CPU13.RC=
U
      5947 =C2=B1  3%    +659.0%      45142 =C2=B1  8%  softirqs.CPU14.RC=
U
      6407 =C2=B1 11%    +606.4%      45259 =C2=B1  9%  softirqs.CPU15.RC=
U
      6614 =C2=B1  6%    +647.9%      49467 =C2=B1 10%  softirqs.CPU16.RC=
U
      7221 =C2=B1  7%    +553.1%      47167 =C2=B1  9%  softirqs.CPU17.RC=
U
      6926 =C2=B1  9%    +578.4%      46989 =C2=B1  9%  softirqs.CPU18.RC=
U
      6566 =C2=B1  4%    +634.3%      48218 =C2=B1  9%  softirqs.CPU19.RC=
U
      7679 =C2=B1 28%    +457.5%      42812 =C2=B1 18%  softirqs.CPU2.RCU
      6611 =C2=B1  3%    +628.6%      48168 =C2=B1 10%  softirqs.CPU20.RC=
U
      6726 =C2=B1  4%    +605.7%      47472 =C2=B1 13%  softirqs.CPU21.RC=
U
      6571 =C2=B1  4%    +638.5%      48528 =C2=B1 10%  softirqs.CPU22.RC=
U
      7565 =C2=B1 19%    +541.6%      48542 =C2=B1 10%  softirqs.CPU23.RC=
U
      8353 =C2=B1 19%    +520.9%      51863 =C2=B1  8%  softirqs.CPU24.RC=
U
      6097 =C2=B1  7%    +632.8%      44682 =C2=B1 14%  softirqs.CPU25.RC=
U
      5926 =C2=B1  7%    +703.2%      47600 =C2=B1  7%  softirqs.CPU26.RC=
U
      6096 =C2=B1  7%    +665.0%      46641 =C2=B1 10%  softirqs.CPU27.RC=
U
      5783 =C2=B1 10%    +719.1%      47372 =C2=B1  6%  softirqs.CPU28.RC=
U
      5998 =C2=B1  7%    +693.9%      47619 =C2=B1  7%  softirqs.CPU29.RC=
U
     10929 =C2=B1 12%    +326.6%      46623 =C2=B1 11%  softirqs.CPU3.RCU
      6860 =C2=B1 36%    +587.4%      47155 =C2=B1  7%  softirqs.CPU30.RC=
U
      5811 =C2=B1  7%    +658.9%      44099 =C2=B1  7%  softirqs.CPU31.RC=
U
      6107 =C2=B1  5%    +677.7%      47497 =C2=B1  6%  softirqs.CPU32.RC=
U
      6072 =C2=B1  6%    +640.9%      44990 =C2=B1  5%  softirqs.CPU33.RC=
U
      6014 =C2=B1  3%    +695.4%      47835 =C2=B1  6%  softirqs.CPU34.RC=
U
      6002 =C2=B1  4%    +679.8%      46801 =C2=B1 10%  softirqs.CPU35.RC=
U
      6323 =C2=B1  9%    +644.9%      47101 =C2=B1 11%  softirqs.CPU36.RC=
U
      5893 =C2=B1  2%    +708.9%      47666 =C2=B1  6%  softirqs.CPU37.RC=
U
      5894 =C2=B1  3%    +702.9%      47322 =C2=B1  5%  softirqs.CPU38.RC=
U
      6129 =C2=B1  3%    +674.8%      47490 =C2=B1  5%  softirqs.CPU39.RC=
U
      6155 =C2=B1  9%    +618.3%      44214 =C2=B1 13%  softirqs.CPU4.RCU
      6324 =C2=B1 11%    +646.7%      47224 =C2=B1  5%  softirqs.CPU40.RC=
U
      5909 =C2=B1  4%    +659.6%      44884 =C2=B1  7%  softirqs.CPU41.RC=
U
      6131 =C2=B1  7%    +680.5%      47855 =C2=B1  5%  softirqs.CPU42.RC=
U
      5907 =C2=B1  2%    +724.0%      48673 =C2=B1  7%  softirqs.CPU43.RC=
U
      6020 =C2=B1  7%    +650.2%      45159 =C2=B1  8%  softirqs.CPU44.RC=
U
      5859 =C2=B1  4%    +728.0%      48510 =C2=B1  8%  softirqs.CPU45.RC=
U
      5877 =C2=B1  5%    +697.1%      46851 =C2=B1  5%  softirqs.CPU46.RC=
U
      5826 =C2=B1  3%    +645.7%      43449 =C2=B1  2%  softirqs.CPU47.RC=
U
      7221 =C2=B1 27%    +562.9%      47870 =C2=B1  4%  softirqs.CPU48.RC=
U
     20592 =C2=B1 38%     -63.5%       7517 =C2=B1 65%  softirqs.CPU48.SC=
HED
      6200 =C2=B1  8%    +597.3%      43232 =C2=B1  9%  softirqs.CPU49.RC=
U
      6992 =C2=B1 17%    +532.4%      44217 =C2=B1  8%  softirqs.CPU5.RCU
      5929 =C2=B1  6%    +686.3%      46619 =C2=B1  9%  softirqs.CPU50.RC=
U
      6678 =C2=B1  8%    +558.3%      43964 =C2=B1  4%  softirqs.CPU51.RC=
U
      6522 =C2=B1 12%    +623.5%      47186 =C2=B1  8%  softirqs.CPU52.RC=
U
      5935 =C2=B1  8%    +680.5%      46325 =C2=B1  4%  softirqs.CPU53.RC=
U
      5873 =C2=B1  8%    +674.1%      45468 =C2=B1  5%  softirqs.CPU54.RC=
U
      5938 =C2=B1  6%    +673.8%      45947 =C2=B1  3%  softirqs.CPU55.RC=
U
      5727 =C2=B1  8%    +693.2%      45435 =C2=B1  3%  softirqs.CPU56.RC=
U
      5878 =C2=B1  7%    +684.8%      46133 =C2=B1  4%  softirqs.CPU57.RC=
U
      5787 =C2=B1  6%    +651.3%      43475 =C2=B1  8%  softirqs.CPU58.RC=
U
      5925 =C2=B1  6%    +673.9%      45855 =C2=B1  4%  softirqs.CPU59.RC=
U
      6262 =C2=B1  4%    +619.3%      45045 =C2=B1 10%  softirqs.CPU6.RCU
      6107 =C2=B1  8%    +619.2%      43923 =C2=B1  6%  softirqs.CPU60.RC=
U
      6101 =C2=B1 13%    +638.9%      45082 =C2=B1  5%  softirqs.CPU61.RC=
U
      6414 =C2=B1 16%    +582.2%      43759 =C2=B1  3%  softirqs.CPU62.RC=
U
      5835 =C2=B1  7%    +712.7%      47419 =C2=B1  5%  softirqs.CPU63.RC=
U
      6121 =C2=B1  7%    +694.5%      48633 =C2=B1  3%  softirqs.CPU64.RC=
U
      6790 =C2=B1 29%    +605.1%      47880 =C2=B1 10%  softirqs.CPU65.RC=
U
      6139 =C2=B1  8%    +678.5%      47797 =C2=B1  9%  softirqs.CPU66.RC=
U
      6002 =C2=B1  5%    +681.1%      46887 =C2=B1  4%  softirqs.CPU67.RC=
U
      5766 =C2=B1  8%    +720.3%      47306 =C2=B1  9%  softirqs.CPU68.RC=
U
      5780 =C2=B1  7%    +802.4%      52160 =C2=B1  4%  softirqs.CPU69.RC=
U
     24983 =C2=B1 37%     -59.8%      10032 =C2=B1110%  softirqs.CPU69.SC=
HED
      6216 =C2=B1  8%    +592.8%      43066 =C2=B1  8%  softirqs.CPU7.RCU
      5838 =C2=B1  5%    +732.2%      48584 =C2=B1  7%  softirqs.CPU70.RC=
U
      6131 =C2=B1  4%    +695.4%      48767 =C2=B1  7%  softirqs.CPU71.RC=
U
      5992 =C2=B1  2%    +688.5%      47249 =C2=B1 10%  softirqs.CPU72.RC=
U
      6138 =C2=B1  5%    +666.4%      47042 =C2=B1 10%  softirqs.CPU73.RC=
U
      5888 =C2=B1  3%    +692.0%      46641 =C2=B1 11%  softirqs.CPU74.RC=
U
      5961 =C2=B1  4%    +649.4%      44673 =C2=B1 12%  softirqs.CPU75.RC=
U
      6367 =C2=B1 17%    +632.7%      46652 =C2=B1 13%  softirqs.CPU76.RC=
U
      6033 =C2=B1  7%    +675.3%      46776 =C2=B1 11%  softirqs.CPU77.RC=
U
      6364 =C2=B1  6%    +634.7%      46759 =C2=B1 13%  softirqs.CPU78.RC=
U
      5892 =C2=B1  4%    +650.1%      44198 =C2=B1 15%  softirqs.CPU79.RC=
U
      6732 =C2=B1 10%    +558.4%      44328 =C2=B1  9%  softirqs.CPU8.RCU
      5826 =C2=B1  3%    +659.8%      44272 =C2=B1  9%  softirqs.CPU80.RC=
U
      5906 =C2=B1  4%    +663.5%      45095 =C2=B1  7%  softirqs.CPU81.RC=
U
      6215 =C2=B1 10%    +621.3%      44831 =C2=B1  9%  softirqs.CPU82.RC=
U
      5892 =C2=B1  3%    +636.1%      43371 =C2=B1  9%  softirqs.CPU83.RC=
U
      5738 =C2=B1  7%    +690.5%      45364 =C2=B1  6%  softirqs.CPU84.RC=
U
      6017 =C2=B1 12%    +634.4%      44190 =C2=B1  8%  softirqs.CPU85.RC=
U
      5960 =C2=B1  5%    +644.9%      44398 =C2=B1  9%  softirqs.CPU86.RC=
U
      6085 =C2=B1 12%    +635.9%      44782 =C2=B1  9%  softirqs.CPU87.RC=
U
      5808 =C2=B1  6%    +662.2%      44277 =C2=B1  9%  softirqs.CPU88.RC=
U
      5887 =C2=B1  5%    +634.6%      43246 =C2=B1  8%  softirqs.CPU89.RC=
U
      5755 =C2=B1  7%    +666.3%      44105 =C2=B1 10%  softirqs.CPU9.RCU
      5865 =C2=B1  6%    +663.9%      44804 =C2=B1  8%  softirqs.CPU90.RC=
U
      5962 =C2=B1  5%    +660.7%      45354 =C2=B1  9%  softirqs.CPU91.RC=
U
      5914 =C2=B1  5%    +624.6%      42854 =C2=B1 10%  softirqs.CPU92.RC=
U
      5940 =C2=B1  9%    +646.3%      44333 =C2=B1  9%  softirqs.CPU93.RC=
U
      5715 =C2=B1  3%    +673.2%      44188 =C2=B1  8%  softirqs.CPU94.RC=
U
      5820 =C2=B1  4%    +659.7%      44215 =C2=B1 10%  softirqs.CPU95.RC=
U
    600723 =C2=B1  3%    +635.8%    4420294 =C2=B1  3%  softirqs.RCU
   1744186 =C2=B1  3%     -11.1%    1551273        softirqs.SCHED
     66.51 =C2=B1  5%     -62.8        3.73 =C2=B1 14%  perf-profile.call=
trace.cycles-pp.page_fault
     66.47 =C2=B1  5%     -62.8        3.71 =C2=B1 14%  perf-profile.call=
trace.cycles-pp.do_page_fault.page_fault
     66.41 =C2=B1  5%     -62.7        3.66 =C2=B1 15%  perf-profile.call=
trace.cycles-pp.__do_page_fault.do_page_fault.page_fault
     66.15 =C2=B1  5%     -62.7        3.43 =C2=B1 15%  perf-profile.call=
trace.cycles-pp.handle_mm_fault.__do_page_fault.do_page_fault.page_fault
     66.02 =C2=B1  5%     -62.7        3.33 =C2=B1 15%  perf-profile.call=
trace.cycles-pp.__handle_mm_fault.handle_mm_fault.__do_page_fault.do_page=
_fault.page_fault
     57.80 =C2=B1  5%     -57.5        0.30 =C2=B1173%  perf-profile.call=
trace.cycles-pp.lookup_memtype.track_pfn_insert.__vm_insert_mixed.dax_iom=
ap_pte_fault.ext4_dax_huge_fault
     55.85 =C2=B1  5%     -55.9        0.00        perf-profile.calltrace=
.cycles-pp._raw_spin_lock.lookup_memtype.track_pfn_insert.__vm_insert_mix=
ed.dax_iomap_pte_fault
     55.26 =C2=B1  5%     -55.3        0.00        perf-profile.calltrace=
.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.lookup_memtype=
.track_pfn_insert.__vm_insert_mixed
     46.70 =C2=B1  6%     -45.8        0.89 =C2=B1 24%  perf-profile.call=
trace.cycles-pp.__do_fault.__handle_mm_fault.handle_mm_fault.__do_page_fa=
ult.do_page_fault
     46.68 =C2=B1  6%     -45.8        0.88 =C2=B1 23%  perf-profile.call=
trace.cycles-pp.ext4_dax_huge_fault.__do_fault.__handle_mm_fault.handle_m=
m_fault.__do_page_fault
     43.98 =C2=B1  6%     -43.2        0.79 =C2=B1 24%  perf-profile.call=
trace.cycles-pp.dax_iomap_pte_fault.ext4_dax_huge_fault.__do_fault.__hand=
le_mm_fault.handle_mm_fault
     41.96 =C2=B1  6%     -41.8        0.18 =C2=B1173%  perf-profile.call=
trace.cycles-pp.__vm_insert_mixed.dax_iomap_pte_fault.ext4_dax_huge_fault=
.__do_fault.__handle_mm_fault
     41.55 =C2=B1  6%     -41.4        0.17 =C2=B1173%  perf-profile.call=
trace.cycles-pp.track_pfn_insert.__vm_insert_mixed.dax_iomap_pte_fault.ex=
t4_dax_huge_fault.__do_fault
     19.15 =C2=B1  5%     -18.3        0.81 =C2=B1 27%  perf-profile.call=
trace.cycles-pp.ext4_dax_huge_fault.do_wp_page.__handle_mm_fault.handle_m=
m_fault.__do_page_fault
     19.17 =C2=B1  5%     -18.3        0.82 =C2=B1 27%  perf-profile.call=
trace.cycles-pp.do_wp_page.__handle_mm_fault.handle_mm_fault.__do_page_fa=
ult.do_page_fault
     17.32 =C2=B1  5%     -17.0        0.36 =C2=B1100%  perf-profile.call=
trace.cycles-pp.dax_iomap_pte_fault.ext4_dax_huge_fault.do_wp_page.__hand=
le_mm_fault.handle_mm_fault
     16.42 =C2=B1  5%     -16.3        0.14 =C2=B1173%  perf-profile.call=
trace.cycles-pp.__vm_insert_mixed.dax_iomap_pte_fault.ext4_dax_huge_fault=
.do_wp_page.__handle_mm_fault
     16.26 =C2=B1  5%     -16.1        0.13 =C2=B1173%  perf-profile.call=
trace.cycles-pp.track_pfn_insert.__vm_insert_mixed.dax_iomap_pte_fault.ex=
t4_dax_huge_fault.do_wp_page
      0.00            +0.6        0.58        perf-profile.calltrace.cycl=
es-pp.__get_io_u
      0.00            +0.8        0.78 =C2=B1 14%  perf-profile.calltrace=
.cycles-pp.__hrtimer_run_queues.hrtimer_interrupt.smp_apic_timer_interrup=
t.apic_timer_interrupt
      0.36 =C2=B1 81%      +0.8        1.16 =C2=B1 24%  perf-profile.call=
trace.cycles-pp.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_ent=
ry.start_kernel
      0.36 =C2=B1 81%      +0.8        1.17 =C2=B1 24%  perf-profile.call=
trace.cycles-pp.cpuidle_enter.do_idle.cpu_startup_entry.start_kernel.seco=
ndary_startup_64
      0.37 =C2=B1 81%      +0.8        1.17 =C2=B1 24%  perf-profile.call=
trace.cycles-pp.do_idle.cpu_startup_entry.start_kernel.secondary_startup_=
64
      0.37 =C2=B1 81%      +0.8        1.17 =C2=B1 24%  perf-profile.call=
trace.cycles-pp.cpu_startup_entry.start_kernel.secondary_startup_64
      0.37 =C2=B1 81%      +0.8        1.17 =C2=B1 24%  perf-profile.call=
trace.cycles-pp.start_kernel.secondary_startup_64
      0.00            +0.9        0.85 =C2=B1 11%  perf-profile.calltrace=
.cycles-pp.dax_iomap_pmd_fault.ext4_dax_huge_fault.__handle_mm_fault.hand=
le_mm_fault.__do_page_fault
      0.00            +1.0        0.98 =C2=B1 10%  perf-profile.calltrace=
.cycles-pp.hrtimer_interrupt.smp_apic_timer_interrupt.apic_timer_interrup=
t
      0.00            +1.0        1.05 =C2=B1 17%  perf-profile.calltrace=
.cycles-pp.io_u_mark_submit
      0.00            +1.1        1.12 =C2=B1  9%  perf-profile.calltrace=
.cycles-pp.smp_apic_timer_interrupt.apic_timer_interrupt
      0.00            +1.2        1.17 =C2=B1  9%  perf-profile.calltrace=
.cycles-pp.apic_timer_interrupt
      0.00            +1.2        1.19 =C2=B1  2%  perf-profile.calltrace=
.cycles-pp.utime_since_now
      0.00            +1.2        1.20 =C2=B1  6%  perf-profile.calltrace=
.cycles-pp.add_clat_sample
      0.00            +1.2        1.21 =C2=B1  5%  perf-profile.calltrace=
.cycles-pp.add_lat_sample
      0.00            +1.2        1.22 =C2=B1  7%  perf-profile.calltrace=
.cycles-pp.ramp_time_over
      0.00            +1.5        1.51 =C2=B1  9%  perf-profile.calltrace=
.cycles-pp.ext4_dax_huge_fault.__handle_mm_fault.handle_mm_fault.__do_pag=
e_fault.do_page_fault
      0.00            +3.6        3.64 =C2=B1  3%  perf-profile.calltrace=
.cycles-pp.get_io_u
      0.00            +4.0        4.02 =C2=B1  3%  perf-profile.calltrace=
.cycles-pp.io_queue_event
      0.00            +4.5        4.46 =C2=B1  4%  perf-profile.calltrace=
.cycles-pp.td_io_queue
      0.00            +5.4        5.40 =C2=B1  4%  perf-profile.calltrace=
.cycles-pp.fio_gettime
      0.00            +9.7        9.71 =C2=B1  4%  perf-profile.calltrace=
.cycles-pp.io_u_sync_complete
     30.84 =C2=B1 13%     +25.9       56.78 =C2=B1  3%  perf-profile.call=
trace.cycles-pp.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_ent=
ry.start_secondary
     30.84 =C2=B1 13%     +26.0       56.80 =C2=B1  3%  perf-profile.call=
trace.cycles-pp.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary.s=
econdary_startup_64
     30.98 =C2=B1 12%     +26.1       57.08 =C2=B1  2%  perf-profile.call=
trace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_=
startup_entry
     30.92 =C2=B1 13%     +26.3       57.20 =C2=B1  3%  perf-profile.call=
trace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_start=
up_64
     30.92 =C2=B1 13%     +26.3       57.21 =C2=B1  3%  perf-profile.call=
trace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64
     30.92 =C2=B1 13%     +26.3       57.21 =C2=B1  3%  perf-profile.call=
trace.cycles-pp.start_secondary.secondary_startup_64
     31.29 =C2=B1 12%     +27.1       58.38 =C2=B1  3%  perf-profile.call=
trace.cycles-pp.secondary_startup_64
     66.53 =C2=B1  5%     -62.8        3.76 =C2=B1 14%  perf-profile.chil=
dren.cycles-pp.page_fault
     66.42 =C2=B1  5%     -62.7        3.69 =C2=B1 14%  perf-profile.chil=
dren.cycles-pp.__do_page_fault
     66.47 =C2=B1  5%     -62.7        3.74 =C2=B1 14%  perf-profile.chil=
dren.cycles-pp.do_page_fault
     66.16 =C2=B1  5%     -62.7        3.46 =C2=B1 15%  perf-profile.chil=
dren.cycles-pp.handle_mm_fault
     66.03 =C2=B1  5%     -62.7        3.35 =C2=B1 15%  perf-profile.chil=
dren.cycles-pp.__handle_mm_fault
     65.85 =C2=B1  5%     -62.7        3.20 =C2=B1 15%  perf-profile.chil=
dren.cycles-pp.ext4_dax_huge_fault
     61.30 =C2=B1  5%     -59.9        1.37 =C2=B1 25%  perf-profile.chil=
dren.cycles-pp.dax_iomap_pte_fault
     58.37 =C2=B1  5%     -57.5        0.86 =C2=B1 28%  perf-profile.chil=
dren.cycles-pp.__vm_insert_mixed
     57.80 =C2=B1  5%     -56.6        1.17 =C2=B1 22%  perf-profile.chil=
dren.cycles-pp.lookup_memtype
     57.80 =C2=B1  5%     -56.6        1.17 =C2=B1 22%  perf-profile.chil=
dren.cycles-pp.track_pfn_insert
     56.37 =C2=B1  5%     -56.0        0.40 =C2=B1 24%  perf-profile.chil=
dren.cycles-pp._raw_spin_lock
     55.28 =C2=B1  5%     -55.2        0.07 =C2=B1 11%  perf-profile.chil=
dren.cycles-pp.native_queued_spin_lock_slowpath
     46.70 =C2=B1  6%     -45.8        0.89 =C2=B1 23%  perf-profile.chil=
dren.cycles-pp.__do_fault
     19.17 =C2=B1  5%     -18.3        0.82 =C2=B1 27%  perf-profile.chil=
dren.cycles-pp.do_wp_page
      2.76 =C2=B1 13%      -2.5        0.28 =C2=B1 13%  perf-profile.chil=
dren.cycles-pp.jbd2__journal_start
      2.67 =C2=B1 13%      -2.5        0.21 =C2=B1 11%  perf-profile.chil=
dren.cycles-pp.start_this_handle
      2.24 =C2=B1 14%      -1.9        0.35 =C2=B1 16%  perf-profile.chil=
dren.cycles-pp.ext4_iomap_begin
      1.71 =C2=B1  9%      -1.2        0.48 =C2=B1 24%  perf-profile.chil=
dren.cycles-pp._raw_read_lock
      1.32 =C2=B1 11%      -1.1        0.18 =C2=B1 14%  perf-profile.chil=
dren.cycles-pp.__ext4_journal_stop
      1.21 =C2=B1 11%      -1.0        0.17 =C2=B1 13%  perf-profile.chil=
dren.cycles-pp.jbd2_journal_stop
      1.73 =C2=B1  3%      -1.0        0.71 =C2=B1 21%  perf-profile.chil=
dren.cycles-pp.pat_pagerange_is_ram
      1.70 =C2=B1  3%      -1.0        0.69 =C2=B1 22%  perf-profile.chil=
dren.cycles-pp.find_next_iomem_res
      1.71 =C2=B1  3%      -1.0        0.71 =C2=B1 21%  perf-profile.chil=
dren.cycles-pp.walk_system_ram_range
      1.07 =C2=B1 15%      -1.0        0.08 =C2=B1 24%  perf-profile.chil=
dren.cycles-pp.jbd2_transaction_committed
      0.79 =C2=B1 14%      -0.7        0.10 =C2=B1 14%  perf-profile.chil=
dren.cycles-pp.__ext4_journal_start_sb
      0.77 =C2=B1 15%      -0.7        0.10 =C2=B1 17%  perf-profile.chil=
dren.cycles-pp.ext4_journal_check_start
      0.55 =C2=B1  3%      -0.5        0.03 =C2=B1100%  perf-profile.chil=
dren.cycles-pp.insert_pfn
      0.27 =C2=B1  2%      -0.1        0.13 =C2=B1 23%  perf-profile.chil=
dren.cycles-pp.sync_regs
      0.20 =C2=B1  6%      -0.1        0.11 =C2=B1 14%  perf-profile.chil=
dren.cycles-pp.rbt_memtype_lookup
      0.13 =C2=B1  3%      -0.1        0.05 =C2=B1 61%  perf-profile.chil=
dren.cycles-pp.dax_insert_entry
      0.10 =C2=B1  3%      -0.1        0.04 =C2=B1 57%  perf-profile.chil=
dren.cycles-pp._raw_spin_lock_irq
      0.13 =C2=B1  5%      -0.1        0.07 =C2=B1 22%  perf-profile.chil=
dren.cycles-pp.dax_unlock_entry
      0.13 =C2=B1  8%      -0.1        0.08 =C2=B1 27%  perf-profile.chil=
dren.cycles-pp.ext4_es_lookup_extent
      0.11 =C2=B1  4%      -0.0        0.07 =C2=B1 22%  perf-profile.chil=
dren.cycles-pp.dax_iomap_pfn
      0.12 =C2=B1  6%      -0.0        0.10 =C2=B1  8%  perf-profile.chil=
dren.cycles-pp.xas_store
      0.08 =C2=B1  5%      +0.0        0.10 =C2=B1  5%  perf-profile.chil=
dren.cycles-pp.___perf_sw_event
      0.16 =C2=B1  6%      +0.0        0.19 =C2=B1  6%  perf-profile.chil=
dren.cycles-pp.grab_mapping_entry
      0.07 =C2=B1  5%      +0.0        0.11 =C2=B1  7%  perf-profile.chil=
dren.cycles-pp.get_unlocked_entry
      0.05 =C2=B1  9%      +0.0        0.10 =C2=B1  8%  perf-profile.chil=
dren.cycles-pp.xas_find_conflict
      0.01 =C2=B1200%      +0.1        0.06 =C2=B1  6%  perf-profile.chil=
dren.cycles-pp.ktime_get_update_offsets_now
      0.00            +0.1        0.05 =C2=B1  8%  perf-profile.children.=
cycles-pp.lapic_next_deadline
      0.00            +0.1        0.05 =C2=B1  8%  perf-profile.children.=
cycles-pp.hrtimer_active
      0.00            +0.1        0.06 =C2=B1  9%  perf-profile.children.=
cycles-pp.td_set_runstate
      0.00            +0.1        0.06 =C2=B1 14%  perf-profile.children.=
cycles-pp.swapgs_restore_regs_and_return_to_usermode
      0.00            +0.1        0.06 =C2=B1 11%  perf-profile.children.=
cycles-pp.__run_perf_stat
      0.00            +0.1        0.06 =C2=B1 11%  perf-profile.children.=
cycles-pp.process_interval
      0.00            +0.1        0.06 =C2=B1 11%  perf-profile.children.=
cycles-pp.read_counters
      0.01 =C2=B1200%      +0.1        0.07 =C2=B1 10%  perf-profile.chil=
dren.cycles-pp.vmacache_find
      0.01 =C2=B1200%      +0.1        0.07 =C2=B1 17%  perf-profile.chil=
dren.cycles-pp.console_unlock
      0.00            +0.1        0.06 =C2=B1 17%  perf-profile.children.=
cycles-pp.cmd_stat
      0.01 =C2=B1200%      +0.1        0.07 =C2=B1 11%  perf-profile.chil=
dren.cycles-pp.find_vma
      0.01 =C2=B1200%      +0.1        0.08 =C2=B1 10%  perf-profile.chil=
dren.cycles-pp.irq_work_run_list
      0.00            +0.1        0.07 =C2=B1 12%  perf-profile.children.=
cycles-pp.queue_full
      0.00            +0.1        0.07 =C2=B1 16%  perf-profile.children.=
cycles-pp.log_io_u
      0.00            +0.1        0.07 =C2=B1 12%  perf-profile.children.=
cycles-pp.ext4_data_block_valid_rcu
      0.00            +0.1        0.07 =C2=B1 28%  perf-profile.children.=
cycles-pp.io_serial_in
      0.00            +0.1        0.07 =C2=B1 10%  perf-profile.children.=
cycles-pp.__ext4_get_inode_loc
      0.08 =C2=B1 19%      +0.1        0.15 =C2=B1  9%  perf-profile.chil=
dren.cycles-pp.ext4_mark_iloc_dirty
      0.00            +0.1        0.08 =C2=B1 27%  perf-profile.children.=
cycles-pp.__x64_sys_poll
      0.00            +0.1        0.08 =C2=B1 27%  perf-profile.children.=
cycles-pp.do_sys_poll
      0.00            +0.1        0.08 =C2=B1 14%  perf-profile.children.=
cycles-pp.get_start_offset
      0.00            +0.1        0.08        perf-profile.children.cycle=
s-pp.lock_file
      0.00            +0.1        0.08 =C2=B1 15%  perf-profile.children.=
cycles-pp.vfs_read
      0.00            +0.1        0.08 =C2=B1 30%  perf-profile.children.=
cycles-pp.rcu_core
      0.00            +0.1        0.08 =C2=B1 10%  perf-profile.children.=
cycles-pp.ksys_read
      0.00            +0.1        0.09 =C2=B1 21%  perf-profile.children.=
cycles-pp.perf_evlist__poll
      0.00            +0.1        0.09 =C2=B1 21%  perf-profile.children.=
cycles-pp.poll
      0.00            +0.1        0.09 =C2=B1  4%  perf-profile.children.=
cycles-pp.flow_threshold_exceeded
      0.00            +0.1        0.10 =C2=B1 14%  perf-profile.children.=
cycles-pp.ext4_reserve_inode_write
      0.00            +0.1        0.10 =C2=B1 33%  perf-profile.children.=
cycles-pp.update_curr
      0.00            +0.1        0.11 =C2=B1 21%  perf-profile.children.=
cycles-pp.native_write_msr
      0.32 =C2=B1 17%      +0.1        0.43 =C2=B1  7%  perf-profile.chil=
dren.cycles-pp.ext4_dirty_inode
      0.00            +0.1        0.11 =C2=B1  7%  perf-profile.children.=
cycles-pp.get_file
      0.00            +0.1        0.11 =C2=B1 19%  perf-profile.children.=
cycles-pp._raw_spin_lock_irqsave
      0.38 =C2=B1 18%      +0.1        0.50 =C2=B1  8%  perf-profile.chil=
dren.cycles-pp.generic_update_time
      0.01 =C2=B1200%      +0.1        0.14 =C2=B1 60%  perf-profile.chil=
dren.cycles-pp.tick_nohz_get_sleep_length
      0.00            +0.1        0.13 =C2=B1  6%  perf-profile.children.=
cycles-pp.put_file_log
      0.00            +0.1        0.13 =C2=B1 40%  perf-profile.children.=
cycles-pp.perf_mux_hrtimer_handler
      0.00            +0.1        0.13 =C2=B1 23%  perf-profile.children.=
cycles-pp.update_load_avg
      0.02 =C2=B1122%      +0.1        0.16 =C2=B1 37%  perf-profile.chil=
dren.cycles-pp.__generic_file_write_iter
      0.02 =C2=B1122%      +0.1        0.16 =C2=B1 37%  perf-profile.chil=
dren.cycles-pp.generic_perform_write
      0.05            +0.1        0.19 =C2=B1 23%  perf-profile.children.=
cycles-pp.dax_wake_entry
      0.02 =C2=B1123%      +0.1        0.17 =C2=B1 37%  perf-profile.chil=
dren.cycles-pp.generic_file_write_iter
      0.02 =C2=B1122%      +0.1        0.17 =C2=B1 38%  perf-profile.chil=
dren.cycles-pp.new_sync_write
      0.02 =C2=B1122%      +0.1        0.17 =C2=B1 37%  perf-profile.chil=
dren.cycles-pp.__GI___libc_write
      0.02 =C2=B1122%      +0.2        0.18 =C2=B1 36%  perf-profile.chil=
dren.cycles-pp.record__pushfn
      0.02 =C2=B1122%      +0.2        0.18 =C2=B1 36%  perf-profile.chil=
dren.cycles-pp.writen
      0.02 =C2=B1122%      +0.2        0.18 =C2=B1 34%  perf-profile.chil=
dren.cycles-pp.ksys_write
      0.02 =C2=B1122%      +0.2        0.18 =C2=B1 34%  perf-profile.chil=
dren.cycles-pp.vfs_write
      0.02 =C2=B1122%      +0.2        0.18 =C2=B1 36%  perf-profile.chil=
dren.cycles-pp.perf_mmap__push
      0.10 =C2=B1 17%      +0.2        0.27 =C2=B1  8%  perf-profile.chil=
dren.cycles-pp.ext4_mark_inode_dirty
      0.03 =C2=B1123%      +0.2        0.19 =C2=B1 35%  perf-profile.chil=
dren.cycles-pp.record__mmap_read_evlist
      0.04 =C2=B1 51%      +0.2        0.21 =C2=B1  5%  perf-profile.chil=
dren.cycles-pp.unlock_file
      0.00            +0.2        0.17 =C2=B1  4%  perf-profile.children.=
cycles-pp.utime_since
      0.00            +0.2        0.20 =C2=B1 26%  perf-profile.children.=
cycles-pp.rcu_sched_clock_irq
      0.00            +0.2        0.20 =C2=B1  2%  perf-profile.children.=
cycles-pp.in_ramp_time
      0.06 =C2=B1 59%      +0.2        0.27 =C2=B1 31%  perf-profile.chil=
dren.cycles-pp.cmd_record
      0.04 =C2=B1 84%      +0.2        0.28 =C2=B1 56%  perf-profile.chil=
dren.cycles-pp.menu_select
      0.00            +0.2        0.24 =C2=B1  4%  perf-profile.children.=
cycles-pp.put_file
      0.03 =C2=B1 82%      +0.2        0.28 =C2=B1 57%  perf-profile.chil=
dren.cycles-pp.__softirqentry_text_start
      0.07 =C2=B1 32%      +0.3        0.33 =C2=B1 25%  perf-profile.chil=
dren.cycles-pp.__libc_start_main
      0.07 =C2=B1 32%      +0.3        0.33 =C2=B1 25%  perf-profile.chil=
dren.cycles-pp.main
      0.07 =C2=B1 32%      +0.3        0.33 =C2=B1 25%  perf-profile.chil=
dren.cycles-pp.run_builtin
      0.00            +0.3        0.30        perf-profile.children.cycle=
s-pp.td_io_prep
      0.00            +0.3        0.31 =C2=B1  2%  perf-profile.children.=
cycles-pp.ntime_since
      0.05 =C2=B1 84%      +0.3        0.36 =C2=B1 54%  perf-profile.chil=
dren.cycles-pp.irq_exit
      0.07 =C2=B1 15%      +0.3        0.40 =C2=B1 26%  perf-profile.chil=
dren.cycles-pp.task_tick_fair
      0.00            +0.4        0.35 =C2=B1 11%  perf-profile.children.=
cycles-pp.io_u_mark_depth
      0.00            +0.4        0.38 =C2=B1 13%  perf-profile.children.=
cycles-pp.vmf_insert_pfn_pmd
      0.09 =C2=B1 17%      +0.4        0.51 =C2=B1 19%  perf-profile.chil=
dren.cycles-pp.scheduler_tick
      0.00            +0.5        0.46 =C2=B1  8%  perf-profile.children.=
cycles-pp.io_u_mark_complete
      0.09 =C2=B1 21%      +0.5        0.56 =C2=B1 16%  perf-profile.chil=
dren.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.09 =C2=B1 21%      +0.5        0.56 =C2=B1 16%  perf-profile.chil=
dren.cycles-pp.do_syscall_64
      0.01 =C2=B1200%      +0.6        0.58        perf-profile.children.=
cycles-pp.__get_io_u
      0.16 =C2=B1 17%      +0.7        0.91 =C2=B1 10%  perf-profile.chil=
dren.cycles-pp.update_process_times
      0.16 =C2=B1 17%      +0.8        0.94 =C2=B1  9%  perf-profile.chil=
dren.cycles-pp.tick_sched_handle
      0.37 =C2=B1 81%      +0.8        1.17 =C2=B1 24%  perf-profile.chil=
dren.cycles-pp.start_kernel
      0.19 =C2=B1 15%      +0.8        1.01 =C2=B1  9%  perf-profile.chil=
dren.cycles-pp.tick_sched_timer
      0.00            +0.9        0.86 =C2=B1 10%  perf-profile.children.=
cycles-pp.dax_iomap_pmd_fault
      0.06 =C2=B1 14%      +1.0        1.05 =C2=B1 16%  perf-profile.chil=
dren.cycles-pp.io_u_mark_submit
      0.24 =C2=B1 14%      +1.0        1.26 =C2=B1  3%  perf-profile.chil=
dren.cycles-pp.__hrtimer_run_queues
      0.07 =C2=B1  6%      +1.1        1.19 =C2=B1  2%  perf-profile.chil=
dren.cycles-pp.utime_since_now
      0.08 =C2=B1  9%      +1.1        1.21 =C2=B1  5%  perf-profile.chil=
dren.cycles-pp.add_lat_sample
      0.06 =C2=B1 12%      +1.1        1.20 =C2=B1  6%  perf-profile.chil=
dren.cycles-pp.add_clat_sample
      0.45 =C2=B1 20%      +1.2        1.66 =C2=B1  5%  perf-profile.chil=
dren.cycles-pp.hrtimer_interrupt
      0.00            +1.2        1.23 =C2=B1  7%  perf-profile.children.=
cycles-pp.ramp_time_over
      0.53 =C2=B1 26%      +1.6        2.09 =C2=B1 14%  perf-profile.chil=
dren.cycles-pp.smp_apic_timer_interrupt
      0.58 =C2=B1 25%      +1.6        2.17 =C2=B1 14%  perf-profile.chil=
dren.cycles-pp.apic_timer_interrupt
      0.27 =C2=B1  9%      +3.5        3.78 =C2=B1  3%  perf-profile.chil=
dren.cycles-pp.get_io_u
      0.16 =C2=B1  7%      +4.9        5.06 =C2=B1  3%  perf-profile.chil=
dren.cycles-pp.td_io_queue
      0.26 =C2=B1  4%      +5.2        5.49 =C2=B1  4%  perf-profile.chil=
dren.cycles-pp.fio_gettime
      0.00            +5.5        5.45 =C2=B1  4%  perf-profile.children.=
cycles-pp.io_queue_event
      0.09 =C2=B1  4%      +8.8        8.92 =C2=B1  4%  perf-profile.chil=
dren.cycles-pp.io_u_sync_complete
     30.98 =C2=B1 12%     +26.1       57.08 =C2=B1  2%  perf-profile.chil=
dren.cycles-pp.intel_idle
     30.92 =C2=B1 13%     +26.3       57.21 =C2=B1  3%  perf-profile.chil=
dren.cycles-pp.start_secondary
     31.21 =C2=B1 12%     +26.8       57.96 =C2=B1  3%  perf-profile.chil=
dren.cycles-pp.cpuidle_enter_state
     31.21 =C2=B1 12%     +26.8       57.97 =C2=B1  3%  perf-profile.chil=
dren.cycles-pp.cpuidle_enter
     31.29 =C2=B1 12%     +27.1       58.38 =C2=B1  3%  perf-profile.chil=
dren.cycles-pp.do_idle
     31.29 =C2=B1 12%     +27.1       58.38 =C2=B1  3%  perf-profile.chil=
dren.cycles-pp.secondary_startup_64
     31.29 =C2=B1 12%     +27.1       58.38 =C2=B1  3%  perf-profile.chil=
dren.cycles-pp.cpu_startup_entry
     54.97 =C2=B1  5%     -54.9        0.07 =C2=B1 11%  perf-profile.self=
.cycles-pp.native_queued_spin_lock_slowpath
      1.38 =C2=B1 16%      -1.3        0.08 =C2=B1 11%  perf-profile.self=
.cycles-pp.start_this_handle
      1.70 =C2=B1  9%      -1.2        0.48 =C2=B1 25%  perf-profile.self=
.cycles-pp._raw_read_lock
      1.18 =C2=B1 11%      -1.1        0.10 =C2=B1 12%  perf-profile.self=
.cycles-pp.jbd2_journal_stop
      1.19 =C2=B1  3%      -0.8        0.38 =C2=B1 16%  perf-profile.self=
.cycles-pp.find_next_iomem_res
      1.09 =C2=B1  3%      -0.7        0.34 =C2=B1 26%  perf-profile.self=
.cycles-pp._raw_spin_lock
      0.73 =C2=B1 15%      -0.6        0.08 =C2=B1 13%  perf-profile.self=
.cycles-pp.ext4_journal_check_start
      0.27 =C2=B1  2%      -0.1        0.13 =C2=B1 23%  perf-profile.self=
.cycles-pp.sync_regs
      0.15 =C2=B1 20%      -0.1        0.04 =C2=B1 58%  perf-profile.self=
.cycles-pp.ext4_iomap_begin
      0.20 =C2=B1  6%      -0.1        0.11 =C2=B1 16%  perf-profile.self=
.cycles-pp.rbt_memtype_lookup
      0.10 =C2=B1  3%      -0.1        0.04 =C2=B1 57%  perf-profile.self=
.cycles-pp._raw_spin_lock_irq
      0.08            -0.0        0.04 =C2=B1 59%  perf-profile.self.cycl=
es-pp.handle_mm_fault
      0.04 =C2=B1 50%      +0.0        0.08 =C2=B1  5%  perf-profile.self=
.cycles-pp.xas_find_conflict
      0.00            +0.1        0.05 =C2=B1  8%  perf-profile.self.cycl=
es-pp.hrtimer_interrupt
      0.00            +0.1        0.05 =C2=B1  8%  perf-profile.self.cycl=
es-pp.log_io_u
      0.00            +0.1        0.05 =C2=B1  8%  perf-profile.self.cycl=
es-pp.ktime_get_update_offsets_now
      0.00            +0.1        0.05 =C2=B1  8%  perf-profile.self.cycl=
es-pp.hrtimer_active
      0.00            +0.1        0.06 =C2=B1  9%  perf-profile.self.cycl=
es-pp.td_set_runstate
      0.00            +0.1        0.06 =C2=B1 11%  perf-profile.self.cycl=
es-pp.io_serial_in
      0.01 =C2=B1200%      +0.1        0.07 =C2=B1 10%  perf-profile.self=
.cycles-pp.vmacache_find
      0.00            +0.1        0.06 =C2=B1  6%  perf-profile.self.cycl=
es-pp.lock_file
      0.00            +0.1        0.07 =C2=B1 17%  perf-profile.self.cycl=
es-pp.ext4_data_block_valid_rcu
      0.00            +0.1        0.07 =C2=B1 12%  perf-profile.self.cycl=
es-pp.queue_full
      0.00            +0.1        0.08 =C2=B1 11%  perf-profile.self.cycl=
es-pp.ext4_mark_iloc_dirty
      0.00            +0.1        0.08 =C2=B1 14%  perf-profile.self.cycl=
es-pp.get_start_offset
      0.00            +0.1        0.08 =C2=B1 10%  perf-profile.self.cycl=
es-pp.get_file
      0.00            +0.1        0.09 =C2=B1  4%  perf-profile.self.cycl=
es-pp.flow_threshold_exceeded
      0.00            +0.1        0.09 =C2=B1 40%  perf-profile.self.cycl=
es-pp.menu_select
      0.00            +0.1        0.09 =C2=B1 15%  perf-profile.self.cycl=
es-pp._raw_spin_lock_irqsave
      0.00            +0.1        0.10 =C2=B1 18%  perf-profile.self.cycl=
es-pp.native_write_msr
      0.00            +0.1        0.10 =C2=B1  4%  perf-profile.self.cycl=
es-pp.put_file_log
      0.04 =C2=B1 50%      +0.1        0.18 =C2=B1 18%  perf-profile.self=
.cycles-pp.dax_wake_entry
      0.04 =C2=B1 51%      +0.2        0.20 =C2=B1  6%  perf-profile.self=
.cycles-pp.unlock_file
      0.00            +0.2        0.17 =C2=B1  4%  perf-profile.self.cycl=
es-pp.utime_since
      0.00            +0.2        0.19 =C2=B1 29%  perf-profile.self.cycl=
es-pp.rcu_sched_clock_irq
      0.00            +0.2        0.20 =C2=B1  3%  perf-profile.self.cycl=
es-pp.in_ramp_time
      0.00            +0.2        0.20 =C2=B1 10%  perf-profile.self.cycl=
es-pp.io_u_mark_depth
      0.00            +0.2        0.22 =C2=B1  5%  perf-profile.self.cycl=
es-pp.put_file
      0.00            +0.2        0.24 =C2=B1  2%  perf-profile.self.cycl=
es-pp.td_io_prep
      0.00            +0.3        0.31 =C2=B1  2%  perf-profile.self.cycl=
es-pp.ntime_since
      0.00            +0.4        0.45 =C2=B1  8%  perf-profile.self.cycl=
es-pp.io_u_mark_complete
      0.00            +0.6        0.57 =C2=B1  2%  perf-profile.self.cycl=
es-pp.__get_io_u
      0.02 =C2=B1122%      +0.7        0.70 =C2=B1 15%  perf-profile.self=
.cycles-pp.io_u_mark_submit
      0.00            +0.9        0.91 =C2=B1  8%  perf-profile.self.cycl=
es-pp.ramp_time_over
      0.07 =C2=B1  6%      +1.1        1.14 =C2=B1  2%  perf-profile.self=
.cycles-pp.utime_since_now
      0.08 =C2=B1  9%      +1.1        1.20 =C2=B1  5%  perf-profile.self=
.cycles-pp.add_lat_sample
      0.06 =C2=B1 12%      +1.1        1.18 =C2=B1  5%  perf-profile.self=
.cycles-pp.add_clat_sample
      0.27 =C2=B1  9%      +3.4        3.70 =C2=B1  3%  perf-profile.self=
.cycles-pp.get_io_u
      0.15 =C2=B1  7%      +4.8        4.92 =C2=B1  3%  perf-profile.self=
.cycles-pp.td_io_queue
      0.25 =C2=B1  6%      +5.1        5.37 =C2=B1  4%  perf-profile.self=
.cycles-pp.fio_gettime
      0.00            +5.4        5.40 =C2=B1  4%  perf-profile.self.cycl=
es-pp.io_queue_event
      0.09 =C2=B1  8%      +7.3        7.38 =C2=B1  4%  perf-profile.self=
.cycles-pp.io_u_sync_complete
     30.98 =C2=B1 12%     +26.1       57.07 =C2=B1  2%  perf-profile.self=
.cycles-pp.intel_idle


                                                                         =
      =20
                                  fio.read_bw_MBps                       =
      =20
                                                                         =
      =20
  50000 +-+--------------------------------------------------------------=
---+  =20
        |  O                                                             =
   |  =20
  45000 +-+   O                        O           O          O          =
   |  =20
  40000 O-+      O O           O  O O                O  O  O     O  O O  =
   |  =20
        |             O     O             O  O  O                        =
   |  =20
  35000 +-+              O                                               =
   |  =20
  30000 +-+                                                              =
   |  =20
        |                                                                =
   |  =20
  25000 +-+                                                              =
   |  =20
  20000 +-+                                                              =
   |  =20
        |                                                                =
   |  =20
  15000 +-+                                                              =
   |  =20
  10000 +-+                                                              =
   |  =20
        |..+..+..+.  .+..+..     .+.+..+..+..+..+..+.+..+..+..  .+..+.+..=
+..|  =20
   5000 +-+--------------------------------------------------------------=
---+  =20
                                                                         =
      =20
                                                                         =
                                                                         =
             =20
                                     fio.read_iops                       =
      =20
                                                                         =
      =20
  1.2e+07 +-+O-----------------------------------------------------------=
---+  =20
  1.1e+07 +-+   O                       O          O          O          =
   |  =20
          O       O  O          O                     O  O  O    O  O  O =
   |  =20
    1e+07 +-+           O    O     O  O       O  O                       =
   |  =20
    9e+06 +-+              O               O                             =
   |  =20
    8e+06 +-+                                                            =
   |  =20
    7e+06 +-+                                                            =
   |  =20
          |                                                              =
   |  =20
    6e+06 +-+                                                            =
   |  =20
    5e+06 +-+                                                            =
   |  =20
    4e+06 +-+                                                            =
   |  =20
    3e+06 +-+                                                            =
   |  =20
          |                                                              =
   |  =20
    2e+06 +-++..+.+..+..+..+.+..+..+..+.+..+..+..+.+..+..+..+.+..+..+..+.=
+..|  =20
    1e+06 +-+------------------------------------------------------------=
---+  =20
                                                                         =
      =20
                                                                         =
                                                                         =
             =20
                               fio.read_clat_mean_us                     =
      =20
                                                                         =
      =20
  8000 +-+---------------------------------------------------------------=
---+  =20
       |                  .+..             .+..+..                       =
   |  =20
  7000 +-++..+..+..+.+..+.    +..+..+..+..+       +..+..+..+..+..+.+..+..=
+..|  =20
       |                                                                 =
   |  =20
  6000 +-+                                                               =
   |  =20
       |                                                                 =
   |  =20
  5000 +-+                                                               =
   |  =20
       |                                                                 =
   |  =20
  4000 +-+                                                               =
   |  =20
       |                                                                 =
   |  =20
  3000 +-+                                                               =
   |  =20
       |                O                                                =
   |  =20
  2000 O-+   O  O  O O     O  O  O  O     O O  O     O  O  O     O O  O  =
   |  =20
       |  O                            O          O           O          =
   |  =20
  1000 +-+---------------------------------------------------------------=
---+  =20
                                                                         =
      =20
                                                                         =
                                                                         =
             =20
                                fio.read_clat_stddev                     =
      =20
                                                                         =
      =20
  16000 +-+--------------------------------------------------------------=
---+  =20
        |        +                                         +             =
+  |  =20
  14000 +-+     : :                                       : :           :=
 : |  =20
  12000 +-+     : :                                       :  :          :=
  :|  =20
        |      :   :                     .+..            :   :         : =
  :|  =20
  10000 +-++.. :   +..+..+..  .+..    .+.    +..+..+.+.. :    +..+..+. : =
   |  =20
        |     +             +.    +.+.                  +             +  =
   |  =20
   8000 +-+                                                              =
   |  =20
        |                                                                =
   |  =20
   6000 +-+                                                              =
   |  =20
   4000 +-+                                                              =
   |  =20
        |                                                                =
   |  =20
   2000 O-+      O O  O  O  O     O O     O  O  O       O           O    =
   |  =20
        |  O  O                O       O           O O     O  O  O    O  =
   |  =20
      0 +-+--------------------------------------------------------------=
---+  =20
                                                                         =
      =20
                                                                         =
                                                                         =
             =20
                                fio.read_clat_90__us                     =
      =20
                                                                         =
      =20
  20000 +-+--------------------------------------------------------------=
---+  =20
        |..+..+..+.+..+..+..+..+..+.+..+..+..+..+..+.+..+..+..+..+..+.+..=
+..|  =20
  18000 +-+                                                              =
   |  =20
  16000 +-+                                                              =
   |  =20
        |                                                                =
   |  =20
  14000 +-+                                                              =
   |  =20
  12000 +-+                                                              =
   |  =20
        |                                                                =
   |  =20
  10000 +-+                                                              =
   |  =20
   8000 +-+                                                              =
   |  =20
        |                                                                =
   |  =20
   6000 +-+                                                              =
   |  =20
   4000 +-+                                                              =
   |  =20
        O             O  O  O  O  O O     O  O  O       O           O    =
   |  =20
   2000 +-+O--O--O-O-------------------O-----------O-O-----O--O--O----O--=
---+  =20
                                                                         =
      =20
                                                                         =
                                                                         =
             =20
                                fio.read_clat_95__us                     =
      =20
                                                                         =
      =20
  22000 +-+--------------------------------------------------------------=
---+  =20
  20000 +-++..+..          .+..+..          .+..+..+.+..+..     .+..+.+..=
   |  =20
        |        +.+..+..+.       +.+..+..+.               +..+.         =
+..|  =20
  18000 +-+                                                              =
   |  =20
  16000 +-+                                                              =
   |  =20
        |                                                                =
   |  =20
  14000 +-+                                                              =
   |  =20
  12000 +-+                                                              =
   |  =20
  10000 +-+                                                              =
   |  =20
        |                                                                =
   |  =20
   8000 +-+                                                              =
   |  =20
   6000 +-+                                                              =
   |  =20
        |                                                                =
   |  =20
   4000 O-+      O O  O  O  O  O  O O     O  O  O    O  O  O     O  O O  =
   |  =20
   2000 +-+O--O------------------------O-----------O----------O----------=
---+  =20
                                                                         =
      =20
                                                                         =
                                                                         =
             =20
                                fio.read_clat_99__us                     =
      =20
                                                                         =
      =20
  24000 +-+--------------------------------------------------------------=
---+  =20
  22000 +-+      +.+..+..+..+.    +.+..+..+..+.            +..+.         =
+..|  =20
        |                                                                =
   |  =20
  20000 +-+                                                              =
   |  =20
  18000 +-+                                                              =
   |  =20
  16000 +-+                                                              =
   |  =20
  14000 +-+                                                              =
   |  =20
        |                                                                =
   |  =20
  12000 +-+                                                              =
   |  =20
  10000 +-+                                                              =
   |  =20
   8000 +-+                                                              =
   |  =20
   6000 +-+                                                              =
   |  =20
        O     O  O O  O  O  O  O  O O     O  O  O  O O  O  O  O  O  O O  =
   |  =20
   4000 +-+O                           O                                 =
   |  =20
   2000 +-+--------------------------------------------------------------=
---+  =20
                                                                         =
      =20
                                                                         =
                                                                         =
             =20
                                  fio.write_bw_MBps                      =
      =20
                                                                         =
      =20
  50000 +-+--------------------------------------------------------------=
---+  =20
        |  O                                                             =
   |  =20
  45000 +-+   O                        O           O          O          =
   |  =20
  40000 O-+      O O           O  O O                O  O  O     O  O O  =
   |  =20
        |             O     O             O  O  O                        =
   |  =20
  35000 +-+              O                                               =
   |  =20
  30000 +-+                                                              =
   |  =20
        |                                                                =
   |  =20
  25000 +-+                                                              =
   |  =20
  20000 +-+                                                              =
   |  =20
        |                                                                =
   |  =20
  15000 +-+                                                              =
   |  =20
  10000 +-+                                                              =
   |  =20
        |..+..+..+.  .+..+..     .+.+..+..+..+..+..+.+..+..+..  .+..+.+..=
+..|  =20
   5000 +-+--------------------------------------------------------------=
---+  =20
                                                                         =
      =20
                                                                         =
                                                                         =
             =20
                                    fio.write_iops                       =
      =20
                                                                         =
      =20
  1.2e+07 +-+O-----------------------------------------------------------=
---+  =20
  1.1e+07 +-+   O                       O          O          O          =
   |  =20
          O       O  O          O                     O  O  O    O  O  O =
   |  =20
    1e+07 +-+           O    O     O  O       O  O                       =
   |  =20
    9e+06 +-+              O               O                             =
   |  =20
    8e+06 +-+                                                            =
   |  =20
    7e+06 +-+                                                            =
   |  =20
          |                                                              =
   |  =20
    6e+06 +-+                                                            =
   |  =20
    5e+06 +-+                                                            =
   |  =20
    4e+06 +-+                                                            =
   |  =20
    3e+06 +-+                                                            =
   |  =20
          |                                                              =
   |  =20
    2e+06 +-++..+.+..+..+..+.+..+..+..+.+..+..+..+.+..+..+..+.+..+..+..+.=
+..|  =20
    1e+06 +-+------------------------------------------------------------=
---+  =20
                                                                         =
      =20
                                                                         =
                                                                         =
             =20
                               fio.write_clat_mean_us                    =
      =20
                                                                         =
      =20
  22000 +-+--------------------------------------------------------------=
---+  =20
  20000 +-++..+..+.+..+..+..+..+..+.+..+..+..+..+..+.+..+..+..+..+..+.+..=
+..|  =20
        |                                                                =
   |  =20
  18000 +-+                                                              =
   |  =20
  16000 +-+                                                              =
   |  =20
  14000 +-+                                                              =
   |  =20
  12000 +-+                                                              =
   |  =20
        |                                                                =
   |  =20
  10000 +-+                                                              =
   |  =20
   8000 +-+                                                              =
   |  =20
   6000 +-+                                                              =
   |  =20
   4000 +-+                                                              =
   |  =20
        |                                                                =
   |  =20
   2000 O-+O  O  O O  O  O  O  O  O O  O  O  O  O  O O  O  O  O  O  O O  =
   |  =20
      0 +-+--------------------------------------------------------------=
---+  =20
                                                                         =
      =20
                                                                         =
                                                                         =
             =20
                                fio.write_clat_90__us                    =
      =20
                                                                         =
      =20
  25000 +-+--------------------------------------------------------------=
---+  =20
        |..+..+..+.+..+..+..+..+..+.+..+..+..+..+..+.+..+..+..+..+..+.+..=
+..|  =20
        |                                                                =
   |  =20
  20000 +-+                                                              =
   |  =20
        |                                                                =
   |  =20
        |                                                                =
   |  =20
  15000 +-+                                                              =
   |  =20
        |                                                                =
   |  =20
  10000 +-+                                                              =
   |  =20
        |                                                                =
   |  =20
        |                                                                =
   |  =20
   5000 +-+                                                              =
   |  =20
        |                O                O                              =
   |  =20
        O  O  O  O O  O     O  O  O O  O     O  O  O O  O  O  O  O  O O  =
   |  =20
      0 +-+--------------------------------------------------------------=
---+  =20
                                                                         =
      =20
                                                                         =
                                                                         =
             =20
                                fio.write_clat_95__us                    =
      =20
                                                                         =
      =20
  30000 +-+--------------------------------------------------------------=
---+  =20
        |                                                                =
   |  =20
  25000 +-++..+..+.+..+..+..+..+..+.+..+..+..+..+..+.+..+..+..+..+..+.+..=
+..|  =20
        |                                                                =
   |  =20
        |                                                                =
   |  =20
  20000 +-+                                                              =
   |  =20
        |                                                                =
   |  =20
  15000 +-+                                                              =
   |  =20
        |                                                                =
   |  =20
  10000 +-+                                                              =
   |  =20
        |                                                                =
   |  =20
        |                                                                =
   |  =20
   5000 +-+              O                O                              =
   |  =20
        O  O  O  O O  O     O  O  O O  O     O  O  O O  O  O  O  O  O O  =
   |  =20
      0 +-+--------------------------------------------------------------=
---+  =20
                                                                         =
      =20
                                                                         =
                                                                         =
             =20
                                fio.write_clat_99__us                    =
      =20
                                                                         =
      =20
  40000 +-+--------------------------------------------------------------=
---+  =20
        |          +..                                        +..        =
   |  =20
  35000 +-+       +        .+..             .+..            ..           =
 ..|  =20
  30000 +-++..+..+    +..+.    +..+.+..+..+.    +..+.+..+..+     +..+.+..=
+  |  =20
        |                                                                =
   |  =20
  25000 +-+                                                              =
   |  =20
        |                                                                =
   |  =20
  20000 +-+                                                              =
   |  =20
        |                                                                =
   |  =20
  15000 +-+                                                              =
   |  =20
  10000 +-+                                                              =
   |  =20
        |                                                                =
   |  =20
   5000 O-+O  O  O O  O  O  O  O  O O  O  O  O  O  O O  O  O  O  O  O O  =
   |  =20
        |                                                                =
   |  =20
      0 +-+--------------------------------------------------------------=
---+  =20
                                                                         =
      =20
                                                                         =
                                                                         =
             =20
                                fio.latency_2us_                         =
      =20
                                                                         =
      =20
  70 +-+O----------------------------------------------------------------=
---+  =20
     |     O                          O          O           O           =
   |  =20
  60 +-+                                            O           O        =
   |  =20
     O        O  O           O                         O  O        O  O  =
   |  =20
  50 +-+            O     O     O  O          O                          =
   |  =20
     |                                     O                             =
   |  =20
  40 +-+                                 O                               =
   |  =20
     |                                                                   =
   |  =20
  30 +-+               O                                                 =
   |  =20
     |                                                                   =
   |  =20
  20 +-+                                                                 =
   |  =20
     |                                                                   =
   |  =20
  10 +-+                                                                 =
   |  =20
     |                                                                   =
   |  =20
   0 +-+-----------------------------------------------------------------=
---+  =20
                                                                         =
      =20
                                                                         =
                                                                         =
             =20
                                fio.latency_20us_                        =
      =20
                                                                         =
      =20
  50 +-+-----------------------------------------------------------------=
---+  =20
  45 +-+              .+..      +..+..+..+                               =
   |  =20
     |..+..+..+..  .+.        ..          +  .+..+..+..+..+..  .+..+..+..=
+..|  =20
  40 +-+         +.       +..+             +.                +.          =
   |  =20
  35 +-+                                                                 =
   |  =20
     |                                                                   =
   |  =20
  30 +-+                                                                 =
   |  =20
  25 +-+                                                                 =
   |  =20
  20 +-+                                                                 =
   |  =20
     |                                                                   =
   |  =20
  15 +-+                                                                 =
   |  =20
  10 +-+                                                                 =
   |  =20
     |                                                                   =
   |  =20
   5 +-+                                                                 =
   |  =20
   0 O-+O--O--O--O--O--O--O--O--O--O--O--O-O--O--O--O--O--O--O--O--O--O--=
---+  =20
                                                                         =
      =20
                                                                         =
                                                                         =
             =20
                                fio.latency_50us_                        =
      =20
                                                                         =
      =20
  35 +-+-----------------------------------------------------------------=
---+  =20
     |                                                                   =
   |  =20
  30 +-+         +..      +..+                               +..         =
   |  =20
     |..       ..        :    +           .+..+..+..       ..   +..      =
 ..|  =20
  25 +-++..+..+     +..  :     +         +          +..+..+        +..+..=
+  |  =20
     |                  :       +..+.. ..                                =
   |  =20
  20 +-+               +              +                                  =
   |  =20
     |                                                                   =
   |  =20
  15 +-+                                                                 =
   |  =20
     |                                                                   =
   |  =20
  10 +-+                                                                 =
   |  =20
     |                                                                   =
   |  =20
   5 +-+                                                                 =
   |  =20
     |                                                                   =
   |  =20
   0 O-+O--O--O--O--O--O--O--O--O--O--O--O-O--O--O--O--O--O--O--O--O--O--=
---+  =20
                                                                         =
      =20
                                                                         =
                                                                         =
             =20
                                     fio.workload                        =
      =20
                                                                         =
      =20
    5e+09 +-+------------------------------------------------------------=
---+  =20
          |  O                          O          O          O          =
   |  =20
  4.5e+09 +-+   O                                     O          O       =
   |  =20
    4e+09 O-+     O  O  O    O  O  O  O       O  O       O  O       O  O =
   |  =20
          |                                O                             =
   |  =20
  3.5e+09 +-+              O                                             =
   |  =20
    3e+09 +-+                                                            =
   |  =20
          |                                                              =
   |  =20
  2.5e+09 +-+                                                            =
   |  =20
    2e+09 +-+                                                            =
   |  =20
          |                                                              =
   |  =20
  1.5e+09 +-+                                                            =
   |  =20
    1e+09 +-+                                                            =
   |  =20
          |..+..+.+..+..+..+.+..+..+..+.+..+..+..+.+..+..+..+.+..+..+..+.=
+..|  =20
    5e+08 +-+------------------------------------------------------------=
---+  =20
                                                                         =
      =20
                                                                         =
                                                                         =
             =20
                                 fio.time.user_time                      =
      =20
                                                                         =
      =20
  10000 +-+--------------------------------------------------------------=
---+  =20
   9000 O-+O  O  O O  O  O  O  O  O O  O  O  O  O  O O  O  O  O  O  O O  =
   |  =20
        |                                                                =
   |  =20
   8000 +-+                                                              =
   |  =20
   7000 +-+                                                              =
   |  =20
        |                                                                =
   |  =20
   6000 +-+                                                              =
   |  =20
   5000 +-+                                                              =
   |  =20
   4000 +-+                                                              =
   |  =20
        |                                                                =
   |  =20
   3000 +-+                                                              =
   |  =20
   2000 +-+                                                              =
   |  =20
        |                                                                =
   |  =20
   1000 +-++..+..+.+..+..+..+..+..+.+..+..+..+..+..+.+..+..+..+..+..+.+..=
+..|  =20
      0 +-+--------------------------------------------------------------=
---+  =20
                                                                         =
      =20
                                                                         =
                                                                         =
             =20
                                fio.time.system_time                     =
      =20
                                                                         =
      =20
  10000 +-+--------------------------------------------------------------=
---+  =20
   9000 +-++..+..+.+..+..+..  .+..+.+..+..+..+..  .+.+..+..+..+..+..+.+..=
+..|  =20
        |                   +.                  +.                       =
   |  =20
   8000 +-+                                                              =
   |  =20
   7000 +-+                                                              =
   |  =20
        |                                                                =
   |  =20
   6000 +-+                                                              =
   |  =20
   5000 +-+                                                              =
   |  =20
   4000 +-+                                                              =
   |  =20
        |                                                                =
   |  =20
   3000 +-+                                                              =
   |  =20
   2000 +-+                                                              =
   |  =20
        |                                                                =
   |  =20
   1000 +-+                                                              =
   |  =20
      0 O-+O--O--O-O--O--O--O--O--O-O--O--O--O--O--O-O--O--O--O--O--O-O--=
---+  =20
                                                                         =
      =20
                                                                         =
                                                                         =
             =20
                       fio.time.percent_of_cpu_this_job_got              =
      =20
                                                                         =
      =20
  4600 +-+---------------------------------------------------------------=
---+  =20
       O  O  O  O  O O  O  O  O  O  O  O  O O  O  O  O  O  O  O  O O  O  =
   |  =20
  4550 +-+                                                               =
   |  =20
  4500 +-+                                                               =
   |  =20
       |                                                                 =
   |  =20
  4450 +-+                                                               =
   |  =20
       |                                                                 =
   |  =20
  4400 +-+                                                               =
   |  =20
       |                                                                 =
   |  =20
  4350 +-+                                                               =
   |  =20
  4300 +-+                                                               =
   |  =20
       |                +..                                              =
   |  =20
  4250 +-+            ..                                                 =
   |  =20
       |..+..+..+..+.+     +..+..+..+..+..+.+..+..+..+..+..+..+..+.+..+..=
+..|  =20
  4200 +-+---------------------------------------------------------------=
---+  =20
                                                                         =
      =20
                                                                         =
                                                                         =
             =20
                               fio.time.elapsed_time                     =
      =20
                                                                         =
      =20
  228 +-+----------------------------------------------------------------=
---+  =20
      |     +.        +   +..+..+.    +.    +.          +.            +. =
   |  =20
  226 +-+              + +                                               =
   |  =20
  224 +-+               +                                                =
   |  =20
      |                                                                  =
   |  =20
  222 +-+                                                                =
   |  =20
  220 +-+                                                                =
   |  =20
      |                                                                  =
   |  =20
  218 +-+                                                                =
   |  =20
  216 +-+                                                                =
   |  =20
      |                                                                  =
   |  =20
  214 +-+                                                                =
   |  =20
  212 +-+                                                                =
   |  =20
      |                                                                  =
   |  =20
  210 O-+O--O--O--O--O--O-O--O--O--O--O--O--O--O--O--O--O--O-O--O--O--O--=
---+  =20
                                                                         =
      =20
                                                                         =
                                                                         =
             =20
                             fio.time.elapsed_time.max                   =
      =20
                                                                         =
      =20
  228 +-+----------------------------------------------------------------=
---+  =20
      |     +.        +   +..+..+.    +.    +.          +.            +. =
   |  =20
  226 +-+              + +                                               =
   |  =20
  224 +-+               +                                                =
   |  =20
      |                                                                  =
   |  =20
  222 +-+                                                                =
   |  =20
  220 +-+                                                                =
   |  =20
      |                                                                  =
   |  =20
  218 +-+                                                                =
   |  =20
  216 +-+                                                                =
   |  =20
      |                                                                  =
   |  =20
  214 +-+                                                                =
   |  =20
  212 +-+                                                                =
   |  =20
      |                                                                  =
   |  =20
  210 O-+O--O--O--O--O--O-O--O--O--O--O--O--O--O--O--O--O--O-O--O--O--O--=
---+  =20
                                                                         =
      =20
                                                                         =
                                                                         =
             =20
                              fio.time.minor_page_faults                 =
      =20
                                                                         =
      =20
    5e+08 +-+------------------------------------------------------------=
---+  =20
          |..+..+.+..+..+.   +..+..+..+    +..+..+.+..+..+..+.+..+..+..+.=
+..|  =20
  4.5e+08 +-+                                                            =
   |  =20
    4e+08 +-+                                                            =
   |  =20
          |                                                              =
   |  =20
  3.5e+08 +-+                                                            =
   |  =20
    3e+08 +-+                                                            =
   |  =20
          |                                                              =
   |  =20
  2.5e+08 +-+                                                            =
   |  =20
    2e+08 +-+                                                            =
   |  =20
          |                                                              =
   |  =20
  1.5e+08 +-+                                                            =
   |  =20
    1e+08 +-+                                                            =
   |  =20
          O  O  O O  O  O  O O  O  O  O O        O O  O  O  O O  O  O  O =
   |  =20
    5e+07 +-+------------------------------O--O--------------------------=
---+  =20
                                                                         =
      =20
                                                                         =
                                                                         =
             =20
                         fio.time.voluntary_context_switches             =
      =20
                                                                         =
      =20
  24000 +-+--------------------------------------------------------------=
---+  =20
        |..+..+..+.+..+..+..+..+..+    +..+..  .+..+.+..+..+..+..+..+.+..=
+..|  =20
  23500 +-+                                  +.                          =
   |  =20
        |                                                                =
   |  =20
        |                                                                =
   |  =20
  23000 +-+                                                              =
   |  =20
        |                                                                =
   |  =20
  22500 +-+                                                              =
   |  =20
        |                                                                =
   |  =20
  22000 +-+                                                              =
   |  =20
        |                                                                =
   |  =20
        |  O                           O                                 =
   |  =20
  21500 O-+   O  O       O  O     O          O     O O  O  O  O  O  O O  =
   |  =20
        |          O  O        O          O     O                        =
   |  =20
  21000 +-+-------------------------O------------------------------------=
---+  =20
                                                                         =
      =20
                                                                         =
      =20
[*] bisect-good sample
[O] bisect-bad  sample

*************************************************************************=
**************************
lkp-csl-2sp6: 96 threads Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz with 25=
6G memory
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
bs/compiler/cpufreq_governor/disk/fs/ioengine/kconfig/mount_option/nr_tas=
k/rootfs/runtime/rw/tbox_group/test_size/testcase/time_based/ucode:
  2M/gcc-7/performance/2pmem/ext4/mmap/x86_64-rhel-7.6/dax/50%/debian-x86=
_64-2019-05-14.cgz/200s/write/lkp-csl-2sp6/200G/fio-basic/tb/0x5000021

commit:=20
  v5.4-rc4
  a70e8083a9 ("fs/dax: Fix pmd vs pte conflict detection")

        v5.4-rc4 a70e8083a91b17a7c77012f7746=20
---------------- ---------------------------=20
       fail:runs  %reproduction    fail:runs
           |             |             |   =20
          1:5          -12%           0:4     perf-profile.children.cycle=
s-pp.error_entry
         %stddev     %change         %stddev
             \          |                \ =20
     22.58 =C2=B1 15%     -21.6        0.94 =C2=B1 79%  fio.latency_10ms%
     77.40 =C2=B1  4%     -77.4        0.01 =C2=B1 24%  fio.latency_20ms%
      0.01 =C2=B1 81%     +60.9       60.94 =C2=B1 59%  fio.latency_2ms%
      0.01 =C2=B1 50%     +36.8       36.85 =C2=B1 97%  fio.latency_4ms%
    227.24            -7.4%     210.34        fio.time.elapsed_time
    227.24            -7.4%     210.34        fio.time.elapsed_time.max
  4.65e+08           -90.4%   44651382 =C2=B1  6%  fio.time.minor_page_fa=
ults
      4235            +8.1%       4577        fio.time.percent_of_cpu_thi=
s_job_got
      9021           -96.5%     314.08 =C2=B1  3%  fio.time.system_time
    603.69 =C2=B1  2%   +1443.2%       9315        fio.time.user_time
     25150 =C2=B1  2%     -10.0%      22623        fio.time.voluntary_con=
text_switches
    907948          +363.7%    4210010 =C2=B1 15%  fio.workload
      9079          +363.7%      42099 =C2=B1 15%  fio.write_bw_MBps
  11180441           -81.1%    2109440 =C2=B1 16%  fio.write_clat_90%_us
  11285299           -80.4%    2211840 =C2=B1 16%  fio.write_clat_95%_us
  11652300           -65.4%    4026368 =C2=B1  7%  fio.write_clat_99%_us
  10493648           -81.5%    1937158 =C2=B1 16%  fio.write_clat_mean_us
    755702 =C2=B1 11%     -43.3%     428848 =C2=B1 12%  fio.write_clat_st=
ddev
      4539          +363.7%      21049 =C2=B1 15%  fio.write_iops
     23285 =C2=B1  5%     -71.3%       6686 =C2=B1 15%  cpuidle.POLL.usag=
e
     41.24           -39.4        1.83 =C2=B1  2%  mpstat.cpu.all.sys%
      2.76 =C2=B1  2%     +44.1       46.82        mpstat.cpu.all.usr%
     56.37            -8.1%      51.80        iostat.cpu.idle
     40.89           -95.6%       1.82 =C2=B1  2%  iostat.cpu.system
      2.74 =C2=B1  2%   +1590.9%      46.39        iostat.cpu.user
   1179347 =C2=B1 15%     -63.3%     433356 =C2=B1 29%  numa-numastat.nod=
e0.local_node
   1204191 =C2=B1 13%     -62.7%     448980 =C2=B1 24%  numa-numastat.nod=
e0.numa_hit
   1384986 =C2=B1 12%     -71.9%     388829 =C2=B1 28%  numa-numastat.nod=
e1.local_node
   1391284 =C2=B1 11%     -70.9%     404502 =C2=B1 23%  numa-numastat.nod=
e1.numa_hit
     56.40            -8.2%      51.75        vmstat.cpu.id
      2.00         +2200.0%      46.00        vmstat.cpu.us
   2102090           -20.3%    1676188        vmstat.memory.cache
      1602            -5.4%       1516        vmstat.system.cs
    504545           -80.7%      97541        meminfo.KReclaimable
  10737953           -14.9%    9139470        meminfo.Memused
   1591563           -89.8%     162150 =C2=B1  5%  meminfo.PageTables
    504545           -80.7%      97541        meminfo.SReclaimable
    685303           -59.1%     280065        meminfo.Slab
     57985           -21.0%      45801        meminfo.max_used_kB
      1244           +12.1%       1394        turbostat.Avg_MHz
     44.66            +5.3       49.96        turbostat.Busy%
     54.06 =C2=B1  2%      -9.3%      49.05        turbostat.CPU%c1
     54.80           +12.2%      61.50        turbostat.CoreTmp
     56.40 =C2=B1  2%      +9.5%      61.75        turbostat.PkgTmp
    247.09           +17.2%     289.48        turbostat.PkgWatt
    137.84           +36.8%     188.59        turbostat.RAMWatt
      2176 =C2=B1 12%     +19.1%       2592 =C2=B1  6%  slabinfo.avc_xper=
ms_data.active_objs
      2176 =C2=B1 12%     +19.1%       2592 =C2=B1  6%  slabinfo.avc_xper=
ms_data.num_objs
      1818 =C2=B1  5%     -35.8%       1167 =C2=B1  5%  slabinfo.dquot.ac=
tive_objs
      1818 =C2=B1  5%     -35.8%       1167 =C2=B1  5%  slabinfo.dquot.nu=
m_objs
     15953 =C2=B1  2%      +8.3%      17277 =C2=B1  2%  slabinfo.kmalloc-=
512.active_objs
     16088 =C2=B1  2%      +8.1%      17385 =C2=B1  3%  slabinfo.kmalloc-=
512.num_objs
    789.20 =C2=B1  5%     +11.3%     878.00 =C2=B1  6%  slabinfo.pool_wor=
kqueue.active_objs
    768474           -92.6%      56580        slabinfo.radix_tree_node.ac=
tive_objs
     13726           -92.6%       1010        slabinfo.radix_tree_node.ac=
tive_slabs
    768688           -92.6%      56646        slabinfo.radix_tree_node.nu=
m_objs
     13726           -92.6%       1010        slabinfo.radix_tree_node.nu=
m_slabs
    310305 =C2=B1 18%     -82.3%      54895 =C2=B1  6%  numa-meminfo.node=
0.KReclaimable
  17976285 =C2=B1  6%      +9.4%   19667753 =C2=B1  7%  numa-meminfo.node=
0.MemFree
    843639 =C2=B1  4%     -92.3%      64794 =C2=B1 44%  numa-meminfo.node=
0.PageTables
    310305 =C2=B1 18%     -82.3%      54895 =C2=B1  6%  numa-meminfo.node=
0.SReclaimable
    408879 =C2=B1 14%     -61.0%     159577 =C2=B1  2%  numa-meminfo.node=
0.Slab
     80122 =C2=B1172%    +150.1%     200350 =C2=B1 93%  numa-meminfo.node=
1.Inactive
     79981 =C2=B1173%    +150.3%     200180 =C2=B1 93%  numa-meminfo.node=
1.Inactive(anon)
    193866 =C2=B1 29%     -78.0%      42668 =C2=B1 10%  numa-meminfo.node=
1.KReclaimable
     84665 =C2=B1166%    +146.3%     208493 =C2=B1 91%  numa-meminfo.node=
1.Mapped
    749499 =C2=B1  4%     -87.0%      97358 =C2=B1 22%  numa-meminfo.node=
1.PageTables
    193866 =C2=B1 29%     -78.0%      42668 =C2=B1 10%  numa-meminfo.node=
1.SReclaimable
    276049 =C2=B1 21%     -56.3%     120510 =C2=B1  3%  numa-meminfo.node=
1.Slab
   4495963 =C2=B1  6%      +9.4%    4918393 =C2=B1  7%  numa-vmstat.node0=
.nr_free_pages
    210021 =C2=B1  4%     -92.3%      16203 =C2=B1 44%  numa-vmstat.node0=
.nr_page_table_pages
     77599 =C2=B1 18%     -82.3%      13719 =C2=B1  6%  numa-vmstat.node0=
.nr_slab_reclaimable
   1659023 =C2=B1  8%     -33.9%    1096193 =C2=B1 18%  numa-vmstat.node0=
.numa_hit
   1633793 =C2=B1  8%     -33.9%    1080213 =C2=B1 17%  numa-vmstat.node0=
.numa_local
     19906 =C2=B1173%    +151.2%      50007 =C2=B1 93%  numa-vmstat.node1=
.nr_inactive_anon
     21108 =C2=B1166%    +147.1%      52152 =C2=B1 91%  numa-vmstat.node1=
.nr_mapped
    186480 =C2=B1  4%     -87.0%      24268 =C2=B1 22%  numa-vmstat.node1=
.nr_page_table_pages
     48450 =C2=B1 29%     -78.0%      10661 =C2=B1 10%  numa-vmstat.node1=
.nr_slab_reclaimable
     19906 =C2=B1173%    +151.2%      50006 =C2=B1 93%  numa-vmstat.node1=
.nr_zone_inactive_anon
   1299939 =C2=B1 11%     -33.2%     868151 =C2=B1 24%  numa-vmstat.node1=
.numa_hit
   1137570 =C2=B1 11%     -38.8%     696149 =C2=B1 28%  numa-vmstat.node1=
.numa_local
    162369 =C2=B1  7%      +5.9%     172002 =C2=B1  8%  numa-vmstat.node1=
.numa_other
    777339            +6.2%     825713        proc-vmstat.nr_active_anon
      5072            +2.7%       5208        proc-vmstat.nr_active_file
    742845            +8.4%     805220        proc-vmstat.nr_anon_pages
      1387            +8.0%       1497        proc-vmstat.nr_anon_transpa=
rent_hugepages
    951491            +4.1%     990957        proc-vmstat.nr_dirty_backgr=
ound_threshold
   1905310            +4.1%    1984338        proc-vmstat.nr_dirty_thresh=
old
   9596723            +4.1%    9991832        proc-vmstat.nr_free_pages
     95152            +8.9%     103606        proc-vmstat.nr_inactive_ano=
n
     96870            +9.3%     105877        proc-vmstat.nr_mapped
    396937 =C2=B1  2%     -89.8%      40520 =C2=B1  5%  proc-vmstat.nr_pa=
ge_table_pages
    125996           -80.6%      24386        proc-vmstat.nr_slab_reclaim=
able
    777339            +6.2%     825713        proc-vmstat.nr_zone_active_=
anon
      5072            +2.7%       5208        proc-vmstat.nr_zone_active_=
file
     95152            +8.9%     103606        proc-vmstat.nr_zone_inactiv=
e_anon
   2621128           -66.5%     879152 =C2=B1  2%  proc-vmstat.numa_hit
   2589980           -67.3%     847841 =C2=B1  2%  proc-vmstat.numa_local
     19962 =C2=B1 21%     +16.8%      23324 =C2=B1 13%  proc-vmstat.numa_=
pages_migrated
     56091 =C2=B1 24%     -35.2%      36320 =C2=B1  6%  proc-vmstat.pgact=
ivate
   3543684           -52.0%    1702505        proc-vmstat.pgalloc_normal
 4.656e+08           -90.3%   45213914 =C2=B1  6%  proc-vmstat.pgfault
   3468918           -52.4%    1650770        proc-vmstat.pgfree
     19962 =C2=B1 21%     +16.8%      23324 =C2=B1 13%  proc-vmstat.pgmig=
rate_success
    907948           -91.3%      78860 =C2=B1  5%  proc-vmstat.thp_fault_=
fallback
     58.57 =C2=B1 16%    +514.0%     359.57 =C2=B1 37%  sched_debug.cfs_r=
q:/.MIN_vruntime.avg
      5269 =C2=B1  9%    +435.2%      28206 =C2=B1 36%  sched_debug.cfs_r=
q:/.MIN_vruntime.max
    551.52 =C2=B1 11%    +473.4%       3162 =C2=B1 37%  sched_debug.cfs_r=
q:/.MIN_vruntime.stddev
    129.89 =C2=B1  7%    +162.5%     340.93 =C2=B1 13%  sched_debug.cfs_r=
q:/.exec_clock.min
     58.59 =C2=B1 16%    +513.9%     359.64 =C2=B1 37%  sched_debug.cfs_r=
q:/.max_vruntime.avg
      5271 =C2=B1  9%    +435.2%      28212 =C2=B1 36%  sched_debug.cfs_r=
q:/.max_vruntime.max
    551.73 =C2=B1 11%    +473.3%       3163 =C2=B1 37%  sched_debug.cfs_r=
q:/.max_vruntime.stddev
      0.02 =C2=B1 13%     +64.9%       0.03 =C2=B1 23%  sched_debug.cfs_r=
q:/.nr_spread_over.avg
    545.21 =C2=B1  3%     -14.2%     467.53 =C2=B1  7%  sched_debug.cfs_r=
q:/.util_est_enqueued.avg
    602620           +37.4%     827802        sched_debug.cpu.avg_idle.av=
g
     47781 =C2=B1 17%    +140.5%     114924 =C2=B1 60%  sched_debug.cpu.a=
vg_idle.min
    366457           -44.7%     202505 =C2=B1  4%  sched_debug.cpu.avg_id=
le.stddev
      2.94 =C2=B1  4%    +825.6%      27.20 =C2=B1 18%  sched_debug.cpu.c=
lock.stddev
      2.94 =C2=B1  4%    +825.6%      27.20 =C2=B1 18%  sched_debug.cpu.c=
lock_task.stddev
      0.00 =C2=B1  4%    +293.4%       0.00        sched_debug.cpu.next_b=
alance.stddev
     16092 =C2=B1 17%     -33.4%      10717 =C2=B1 14%  sched_debug.cpu.s=
ched_count.max
     83.25 =C2=B1  8%     +92.4%     160.19 =C2=B1 31%  sched_debug.cpu.s=
ched_count.min
    711.37 =C2=B1  2%      -9.8%     641.54        sched_debug.cpu.sched_=
goidle.avg
      8020 =C2=B1 17%     -33.9%       5302 =C2=B1 14%  sched_debug.cpu.s=
ched_goidle.max
     22.80 =C2=B1  2%     -72.3%       6.31 =C2=B1 13%  sched_debug.cpu.s=
ched_goidle.min
      8084 =C2=B1 19%     -38.5%       4968 =C2=B1 21%  sched_debug.cpu.t=
twu_count.max
     50.55 =C2=B1  7%    +105.0%     103.62 =C2=B1 43%  sched_debug.cpu.t=
twu_count.min
      1295 =C2=B1  9%     -33.3%     864.58 =C2=B1 15%  sched_debug.cpu.t=
twu_count.stddev
    448.69 =C2=B1  2%     -12.4%     392.94        sched_debug.cpu.ttwu_l=
ocal.avg
     30.35 =C2=B1  6%     +57.7%      47.88 =C2=B1 36%  sched_debug.cpu.t=
twu_local.min
    945.06 =C2=B1 20%     -33.1%     632.26 =C2=B1 11%  sched_debug.cpu.t=
twu_local.stddev
      5.20 =C2=B1 80%   +1823.1%     100.00 =C2=B1 81%  interrupts.CPU12.=
RES:Rescheduling_interrupts
      2.20 =C2=B1 72%   +3934.1%      88.75 =C2=B1 62%  interrupts.CPU13.=
RES:Rescheduling_interrupts
     95.60 =C2=B1 85%     -67.8%      30.75 =C2=B1 44%  interrupts.CPU13.=
TLB:TLB_shootdowns
      0.80 =C2=B1 93%  +31775.0%     255.00 =C2=B1143%  interrupts.CPU15.=
RES:Rescheduling_interrupts
      1.20 =C2=B1 81%  +56733.3%     682.00 =C2=B1162%  interrupts.CPU21.=
RES:Rescheduling_interrupts
      2.00 =C2=B1 44%   +3025.0%      62.50 =C2=B1 40%  interrupts.CPU22.=
RES:Rescheduling_interrupts
      4.40 =C2=B1 71%  +15718.2%     696.00 =C2=B1135%  interrupts.CPU23.=
RES:Rescheduling_interrupts
      7.60 =C2=B1121%   +2702.6%     213.00 =C2=B1148%  interrupts.CPU27.=
RES:Rescheduling_interrupts
     32.00 =C2=B1181%    +476.6%     184.50 =C2=B1 57%  interrupts.CPU3.R=
ES:Rescheduling_interrupts
      1.20 =C2=B1 97%  +45858.3%     551.50 =C2=B1166%  interrupts.CPU33.=
RES:Rescheduling_interrupts
     15.40 =C2=B1 80%    +679.2%     120.00 =C2=B1 84%  interrupts.CPU5.R=
ES:Rescheduling_interrupts
      4.60 =C2=B1168%   +2150.0%     103.50 =C2=B1 57%  interrupts.CPU50.=
RES:Rescheduling_interrupts
      7.60 =C2=B1104%   +1232.2%     101.25 =C2=B1 55%  interrupts.CPU51.=
RES:Rescheduling_interrupts
      4.60 =C2=B1168%  +10590.2%     491.75 =C2=B1136%  interrupts.CPU53.=
RES:Rescheduling_interrupts
      8.40 =C2=B1194%   +2120.2%     186.50 =C2=B1 87%  interrupts.CPU55.=
RES:Rescheduling_interrupts
      7.60 =C2=B1193%   +1011.8%      84.50 =C2=B1 24%  interrupts.CPU58.=
RES:Rescheduling_interrupts
      3.80 =C2=B1187%   +3307.9%     129.50 =C2=B1 65%  interrupts.CPU59.=
RES:Rescheduling_interrupts
      2530           +15.3%       2918 =C2=B1  8%  interrupts.CPU60.CAL:F=
unction_call_interrupts
      3.40 =C2=B1171%   +6841.2%     236.00 =C2=B1110%  interrupts.CPU60.=
RES:Rescheduling_interrupts
      2.80 =C2=B1165%   +5132.1%     146.50 =C2=B1 82%  interrupts.CPU61.=
RES:Rescheduling_interrupts
      5.60 =C2=B1200%   +1859.8%     109.75 =C2=B1 38%  interrupts.CPU63.=
RES:Rescheduling_interrupts
      2.80 =C2=B1182%   +2739.3%      79.50 =C2=B1 24%  interrupts.CPU64.=
RES:Rescheduling_interrupts
      2.80 =C2=B1182%   +3301.8%      95.25 =C2=B1 47%  interrupts.CPU66.=
RES:Rescheduling_interrupts
      1.80 =C2=B1123%   +8622.2%     157.00 =C2=B1105%  interrupts.CPU69.=
RES:Rescheduling_interrupts
      2540 =C2=B1 35%     +63.1%       4143 =C2=B1 13%  interrupts.CPU7.N=
MI:Non-maskable_interrupts
      2540 =C2=B1 35%     +63.1%       4143 =C2=B1 13%  interrupts.CPU7.P=
MI:Performance_monitoring_interrupts
      7.80 =C2=B1112%   +3980.1%     318.25 =C2=B1127%  interrupts.CPU7.R=
ES:Rescheduling_interrupts
      2918 =C2=B1 31%     +40.2%       4092 =C2=B1 18%  interrupts.CPU79.=
NMI:Non-maskable_interrupts
      2918 =C2=B1 31%     +40.2%       4092 =C2=B1 18%  interrupts.CPU79.=
PMI:Performance_monitoring_interrupts
      5.00 =C2=B1111%   +1120.0%      61.00 =C2=B1111%  interrupts.CPU8.R=
ES:Rescheduling_interrupts
      2499 =C2=B1 33%     +58.8%       3968 =C2=B1 19%  interrupts.CPU80.=
NMI:Non-maskable_interrupts
      2499 =C2=B1 33%     +58.8%       3968 =C2=B1 19%  interrupts.CPU80.=
PMI:Performance_monitoring_interrupts
      2930 =C2=B1 30%     +56.6%       4590 =C2=B1 36%  interrupts.CPU81.=
NMI:Non-maskable_interrupts
      2930 =C2=B1 30%     +56.6%       4590 =C2=B1 36%  interrupts.CPU81.=
PMI:Performance_monitoring_interrupts
      2864 =C2=B1 31%     +40.6%       4026 =C2=B1 21%  interrupts.CPU85.=
NMI:Non-maskable_interrupts
      2864 =C2=B1 31%     +40.6%       4026 =C2=B1 21%  interrupts.CPU85.=
PMI:Performance_monitoring_interrupts
      2880 =C2=B1 33%     +42.5%       4106 =C2=B1 20%  interrupts.CPU86.=
NMI:Non-maskable_interrupts
      2880 =C2=B1 33%     +42.5%       4106 =C2=B1 20%  interrupts.CPU86.=
PMI:Performance_monitoring_interrupts
      6.60 =C2=B1118%   +2365.9%     162.75 =C2=B1 41%  interrupts.CPU9.R=
ES:Rescheduling_interrupts
      2516 =C2=B1 34%     +60.4%       4037 =C2=B1 21%  interrupts.CPU90.=
NMI:Non-maskable_interrupts
      2516 =C2=B1 34%     +60.4%       4037 =C2=B1 21%  interrupts.CPU90.=
PMI:Performance_monitoring_interrupts
     19.60 =C2=B1 99%    +185.7%      56.00 =C2=B1 64%  interrupts.CPU90.=
RES:Rescheduling_interrupts
     45.80 =C2=B1 57%    +110.2%      96.25 =C2=B1 39%  interrupts.CPU90.=
TLB:TLB_shootdowns
      2480 =C2=B1 35%     +63.8%       4062 =C2=B1 21%  interrupts.CPU91.=
NMI:Non-maskable_interrupts
      2480 =C2=B1 35%     +63.8%       4062 =C2=B1 21%  interrupts.CPU91.=
PMI:Performance_monitoring_interrupts
      2745 =C2=B1 25%     +46.3%       4016 =C2=B1 20%  interrupts.CPU92.=
NMI:Non-maskable_interrupts
      2745 =C2=B1 25%     +46.3%       4016 =C2=B1 20%  interrupts.CPU92.=
PMI:Performance_monitoring_interrupts
     15.80 =C2=B1 62%    +469.6%      90.00 =C2=B1 73%  interrupts.CPU92.=
RES:Rescheduling_interrupts
      2496 =C2=B1 34%     +61.0%       4020 =C2=B1 20%  interrupts.CPU93.=
NMI:Non-maskable_interrupts
      2496 =C2=B1 34%     +61.0%       4020 =C2=B1 20%  interrupts.CPU93.=
PMI:Performance_monitoring_interrupts
     14.60 =C2=B1 61%    +679.1%     113.75 =C2=B1 94%  interrupts.CPU93.=
RES:Rescheduling_interrupts
     46.20 =C2=B1 52%     +47.7%      68.25 =C2=B1 41%  interrupts.CPU93.=
TLB:TLB_shootdowns
      2512 =C2=B1 34%     +61.5%       4056 =C2=B1 18%  interrupts.CPU94.=
NMI:Non-maskable_interrupts
      2512 =C2=B1 34%     +61.5%       4056 =C2=B1 18%  interrupts.CPU94.=
PMI:Performance_monitoring_interrupts
     20.40 =C2=B1 67%    +221.1%      65.50 =C2=B1 69%  interrupts.CPU94.=
RES:Rescheduling_interrupts
    506.40 =C2=B1 27%     -36.5%     321.75 =C2=B1 12%  interrupts.IWI:IR=
Q_work_interrupts
     26.37 =C2=B1  5%   +1527.5%     429.21 =C2=B1  5%  perf-stat.i.MPKI
 4.044e+09 =C2=B1  4%     -86.6%  5.422e+08 =C2=B1  6%  perf-stat.i.branc=
h-instructions
      0.36 =C2=B1  5%      +0.4        0.71 =C2=B1  7%  perf-stat.i.branc=
h-miss-rate%
  13139077 =C2=B1  2%     -71.0%    3808633 =C2=B1  2%  perf-stat.i.branc=
h-misses
     40.81 =C2=B1  5%      +3.0       43.77 =C2=B1  3%  perf-stat.i.cache=
-miss-rate%
 2.185e+08 =C2=B1  6%    +150.0%  5.462e+08 =C2=B1 10%  perf-stat.i.cache=
-misses
  5.04e+08 =C2=B1  4%    +141.9%  1.219e+09 =C2=B1 13%  perf-stat.i.cache=
-references
      1545            -6.2%       1449        perf-stat.i.context-switche=
s
      6.27 =C2=B1  3%    +638.0%      46.28 =C2=B1  8%  perf-stat.i.cpi
  1.19e+11            +9.2%  1.299e+11        perf-stat.i.cpu-cycles
    890.35 =C2=B1 10%     -42.9%     508.33 =C2=B1 11%  perf-stat.i.cycle=
s-between-cache-misses
   2315604 =C2=B1  3%     -85.8%     329151 =C2=B1  4%  perf-stat.i.dTLB-=
load-misses
 4.693e+09 =C2=B1  3%     -84.4%   7.32e+08 =C2=B1  6%  perf-stat.i.dTLB-=
loads
      2.76 =C2=B1  3%      -1.5        1.24 =C2=B1  3%  perf-stat.i.dTLB-=
store-miss-rate%
  56407157 =C2=B1  3%     -87.3%    7140595 =C2=B1  6%  perf-stat.i.dTLB-=
store-misses
 1.824e+09           -68.8%  5.692e+08 =C2=B1  9%  perf-stat.i.dTLB-store=
s
     75.83           -20.8       55.02 =C2=B1  2%  perf-stat.i.iTLB-load-=
miss-rate%
  11955091           -73.7%    3145209 =C2=B1  7%  perf-stat.i.iTLB-load-=
misses
   3255737           -22.2%    2533427 =C2=B1  3%  perf-stat.i.iTLB-loads
 1.772e+10 =C2=B1  3%     -83.7%  2.883e+09 =C2=B1  7%  perf-stat.i.instr=
uctions
      1717 =C2=B1  5%     -44.3%     956.76 =C2=B1  3%  perf-stat.i.instr=
uctions-per-iTLB-miss
      0.22 =C2=B1  2%     -81.5%       0.04 =C2=B1  7%  perf-stat.i.ipc
   2041764           -89.4%     216527 =C2=B1  6%  perf-stat.i.minor-faul=
ts
     46.19 =C2=B1  7%     -41.3        4.92 =C2=B1  8%  perf-stat.i.node-=
load-miss-rate%
  12550181 =C2=B1 15%     -83.5%    2075631 =C2=B1 23%  perf-stat.i.node-=
load-misses
  17032624 =C2=B1  3%    +654.5%  1.285e+08 =C2=B1 27%  perf-stat.i.node-=
loads
  39521035 =C2=B1 10%    +177.3%  1.096e+08 =C2=B1 35%  perf-stat.i.node-=
store-misses
  22609084 =C2=B1 19%    +442.8%  1.227e+08 =C2=B1 41%  perf-stat.i.node-=
stores
   2041781           -89.4%     216529 =C2=B1  6%  perf-stat.i.page-fault=
s
     28.49 =C2=B1  6%   +1379.4%     421.53 =C2=B1  5%  perf-stat.overall=
.MPKI
      0.33 =C2=B1  2%      +0.4        0.71 =C2=B1  7%  perf-stat.overall=
.branch-miss-rate%
      6.72 =C2=B1  3%    +575.2%      45.40 =C2=B1  8%  perf-stat.overall=
.cpi
    547.41 =C2=B1  7%     -56.1%     240.54 =C2=B1 10%  perf-stat.overall=
.cycles-between-cache-misses
      0.05 =C2=B1  2%      -0.0        0.05 =C2=B1  4%  perf-stat.overall=
.dTLB-load-miss-rate%
      3.00 =C2=B1  3%      -1.8        1.24 =C2=B1  2%  perf-stat.overall=
.dTLB-store-miss-rate%
     78.60           -23.3       55.31 =C2=B1  2%  perf-stat.overall.iTLB=
-load-miss-rate%
      1482 =C2=B1  4%     -38.2%     916.91 =C2=B1  4%  perf-stat.overall=
.instructions-per-iTLB-miss
      0.15 =C2=B1  3%     -85.1%       0.02 =C2=B1  7%  perf-stat.overall=
.ipc
     42.15 =C2=B1  8%     -40.5        1.61 =C2=B1 11%  perf-stat.overall=
.node-load-miss-rate%
   4422813 =C2=B1  3%     -96.7%     143888 =C2=B1  7%  perf-stat.overall=
.path-length
 4.027e+09 =C2=B1  4%     -86.6%  5.393e+08 =C2=B1  6%  perf-stat.ps.bran=
ch-instructions
  13081765 =C2=B1  2%     -71.0%    3788024 =C2=B1  2%  perf-stat.ps.bran=
ch-misses
 2.175e+08 =C2=B1  6%    +150.1%  5.441e+08 =C2=B1 10%  perf-stat.ps.cach=
e-misses
 5.018e+08 =C2=B1  4%    +142.0%  1.214e+09 =C2=B1 13%  perf-stat.ps.cach=
e-references
      1538            -6.2%       1442        perf-stat.ps.context-switch=
es
 1.185e+11            +9.2%  1.294e+11        perf-stat.ps.cpu-cycles
   2305544 =C2=B1  3%     -85.8%     327568 =C2=B1  4%  perf-stat.ps.dTLB=
-load-misses
 4.673e+09 =C2=B1  3%     -84.4%  7.286e+08 =C2=B1  6%  perf-stat.ps.dTLB=
-loads
  56162654 =C2=B1  3%     -87.3%    7112891 =C2=B1  6%  perf-stat.ps.dTLB=
-store-misses
 1.816e+09           -68.8%  5.663e+08 =C2=B1  9%  perf-stat.ps.dTLB-stor=
es
  11903152           -73.7%    3131396 =C2=B1  7%  perf-stat.ps.iTLB-load=
-misses
   3241524           -22.2%    2522758 =C2=B1  2%  perf-stat.ps.iTLB-load=
s
 1.764e+10 =C2=B1  3%     -83.7%  2.868e+09 =C2=B1  7%  perf-stat.ps.inst=
ructions
   2032916           -89.4%     215676 =C2=B1  6%  perf-stat.ps.minor-fau=
lts
  12495695 =C2=B1 15%     -83.5%    2063340 =C2=B1 23%  perf-stat.ps.node=
-load-misses
  16958923 =C2=B1  3%    +655.0%   1.28e+08 =C2=B1 27%  perf-stat.ps.node=
-loads
  39349478 =C2=B1 10%    +177.4%  1.092e+08 =C2=B1 35%  perf-stat.ps.node=
-store-misses
  22511418 =C2=B1 19%    +442.9%  1.222e+08 =C2=B1 41%  perf-stat.ps.node=
-stores
   2032932           -89.4%     215678 =C2=B1  6%  perf-stat.ps.page-faul=
ts
 4.015e+12 =C2=B1  3%     -85.1%  5.985e+11 =C2=B1  7%  perf-stat.total.i=
nstructions
      7276 =C2=B1 14%    +461.8%      40876 =C2=B1  6%  softirqs.CPU0.RCU
      7428 =C2=B1 27%    +499.5%      44535 =C2=B1  9%  softirqs.CPU1.RCU
     90558 =C2=B1 18%     -19.2%      73203 =C2=B1  3%  softirqs.CPU1.TIM=
ER
      7372 =C2=B1 31%    +494.3%      43809 =C2=B1  5%  softirqs.CPU10.RC=
U
      6380 =C2=B1  5%    +597.8%      44523 =C2=B1  6%  softirqs.CPU11.RC=
U
     26925 =C2=B1 21%     -63.9%       9707 =C2=B1101%  softirqs.CPU11.SC=
HED
     95764 =C2=B1 17%     -22.9%      73876 =C2=B1  6%  softirqs.CPU11.TI=
MER
      6839 =C2=B1 21%    +532.9%      43287 =C2=B1  6%  softirqs.CPU12.RC=
U
      6195 =C2=B1  4%    +608.2%      43878 =C2=B1  7%  softirqs.CPU13.RC=
U
      6379 =C2=B1  7%    +542.5%      40985        softirqs.CPU14.RCU
      6234 =C2=B1  6%    +601.4%      43724 =C2=B1  6%  softirqs.CPU15.RC=
U
      6744 =C2=B1  4%    +594.0%      46802 =C2=B1  9%  softirqs.CPU16.RC=
U
     96371 =C2=B1 16%     -25.5%      71817 =C2=B1  4%  softirqs.CPU16.TI=
MER
      6560 =C2=B1  3%    +608.8%      46502 =C2=B1 10%  softirqs.CPU17.RC=
U
      6456 =C2=B1  2%    +662.1%      49208 =C2=B1  3%  softirqs.CPU18.RC=
U
     21824 =C2=B1 40%     -80.9%       4168 =C2=B1 10%  softirqs.CPU18.SC=
HED
      7235 =C2=B1 23%    +550.6%      47074 =C2=B1 10%  softirqs.CPU19.RC=
U
      7523 =C2=B1 27%    +487.8%      44225 =C2=B1  9%  softirqs.CPU2.RCU
      7973 =C2=B1 26%    +486.7%      46778 =C2=B1 10%  softirqs.CPU20.RC=
U
      6831 =C2=B1  4%    +615.9%      48903 =C2=B1  6%  softirqs.CPU21.RC=
U
     24201 =C2=B1 37%     -57.4%      10314 =C2=B1 95%  softirqs.CPU21.SC=
HED
      6985 =C2=B1  8%    +525.8%      43713 =C2=B1 10%  softirqs.CPU22.RC=
U
      6729 =C2=B1  9%    +509.6%      41024 =C2=B1  5%  softirqs.CPU23.RC=
U
      7647 =C2=B1  7%    +561.8%      50609 =C2=B1  7%  softirqs.CPU24.RC=
U
      6613 =C2=B1  8%    +607.1%      46768 =C2=B1  7%  softirqs.CPU25.RC=
U
      6228 =C2=B1  5%    +607.8%      44084 =C2=B1 10%  softirqs.CPU26.RC=
U
      6370 =C2=B1  4%    +590.8%      44004 =C2=B1  9%  softirqs.CPU27.RC=
U
      5960 =C2=B1  5%    +668.2%      45791 =C2=B1 12%  softirqs.CPU28.RC=
U
      6476 =C2=B1  8%    +589.5%      44652 =C2=B1  7%  softirqs.CPU29.RC=
U
      8136 =C2=B1 21%    +464.6%      45941 =C2=B1  9%  softirqs.CPU3.RCU
      6270 =C2=B1 10%    +634.2%      46042 =C2=B1  7%  softirqs.CPU30.RC=
U
      6267 =C2=B1  5%    +605.2%      44200 =C2=B1 10%  softirqs.CPU31.RC=
U
      5940 =C2=B1  2%    +656.6%      44941 =C2=B1  6%  softirqs.CPU32.RC=
U
      6015 =C2=B1  2%    +640.3%      44535 =C2=B1 11%  softirqs.CPU33.RC=
U
      5833 =C2=B1  3%    +620.7%      42042 =C2=B1 11%  softirqs.CPU34.RC=
U
      7405 =C2=B1 32%    +512.2%      45332 =C2=B1  6%  softirqs.CPU35.RC=
U
      5908 =C2=B1  5%    +663.2%      45091 =C2=B1  6%  softirqs.CPU36.RC=
U
      6216 =C2=B1  2%    +650.7%      46666 =C2=B1  7%  softirqs.CPU37.RC=
U
      5960          +637.4%      43954 =C2=B1  4%  softirqs.CPU38.RCU
      5806 =C2=B1  5%    +670.3%      44725 =C2=B1  4%  softirqs.CPU39.RC=
U
      6711 =C2=B1  8%    +561.7%      44406 =C2=B1  9%  softirqs.CPU4.RCU
      5746 =C2=B1  4%    +677.9%      44698 =C2=B1  6%  softirqs.CPU40.RC=
U
      5945 =C2=B1  3%    +658.4%      45090 =C2=B1  4%  softirqs.CPU41.RC=
U
      5935 =C2=B1  2%    +680.0%      46293 =C2=B1  5%  softirqs.CPU42.RC=
U
      5880          +676.0%      45628 =C2=B1  5%  softirqs.CPU43.RCU
      5908          +669.4%      45463 =C2=B1  5%  softirqs.CPU44.RCU
      5996 =C2=B1  2%    +656.0%      45334 =C2=B1  5%  softirqs.CPU45.RC=
U
      6450 =C2=B1  7%    +598.1%      45026 =C2=B1  5%  softirqs.CPU46.RC=
U
      5566 =C2=B1 12%    +603.2%      39142 =C2=B1  9%  softirqs.CPU47.RC=
U
      6942 =C2=B1 12%    +574.0%      46795 =C2=B1  4%  softirqs.CPU48.RC=
U
      6225 =C2=B1  4%    +602.6%      43742 =C2=B1 11%  softirqs.CPU49.RC=
U
      6666 =C2=B1 21%    +565.3%      44356 =C2=B1  3%  softirqs.CPU5.RCU
     25268 =C2=B1 38%     -60.3%      10034 =C2=B1105%  softirqs.CPU5.SCH=
ED
      6271 =C2=B1  8%    +596.6%      43690 =C2=B1 10%  softirqs.CPU50.RC=
U
      5995 =C2=B1  7%    +631.4%      43848 =C2=B1 10%  softirqs.CPU51.RC=
U
      7059 =C2=B1 31%    +494.0%      41931 =C2=B1 18%  softirqs.CPU52.RC=
U
      6309 =C2=B1  6%    +541.8%      40493 =C2=B1 14%  softirqs.CPU53.RC=
U
      6369 =C2=B1  3%    +577.4%      43144 =C2=B1 10%  softirqs.CPU54.RC=
U
      6443 =C2=B1 13%    +544.3%      41520 =C2=B1  9%  softirqs.CPU55.RC=
U
      6359 =C2=B1 14%    +559.3%      41923 =C2=B1 12%  softirqs.CPU56.RC=
U
      6309 =C2=B1  5%    +601.7%      44273 =C2=B1  9%  softirqs.CPU57.RC=
U
      6342 =C2=B1 11%    +585.7%      43490 =C2=B1 11%  softirqs.CPU58.RC=
U
      6249 =C2=B1  6%    +547.2%      40445 =C2=B1 13%  softirqs.CPU59.RC=
U
      6260 =C2=B1 10%    +609.4%      44414 =C2=B1  7%  softirqs.CPU6.RCU
      6397 =C2=B1 15%    +582.1%      43638 =C2=B1 14%  softirqs.CPU60.RC=
U
      6411 =C2=B1  9%    +613.7%      45759 =C2=B1  6%  softirqs.CPU61.RC=
U
      6225 =C2=B1  7%    +602.2%      43716 =C2=B1  3%  softirqs.CPU62.RC=
U
      6169 =C2=B1  7%    +592.9%      42749 =C2=B1 11%  softirqs.CPU63.RC=
U
      6528 =C2=B1  7%    +605.1%      46029 =C2=B1  9%  softirqs.CPU64.RC=
U
      6488 =C2=B1 12%    +601.3%      45497 =C2=B1 10%  softirqs.CPU65.RC=
U
      6408 =C2=B1  7%    +506.0%      38834 =C2=B1  6%  softirqs.CPU66.RC=
U
      6431 =C2=B1  5%    +601.7%      45124 =C2=B1 10%  softirqs.CPU67.RC=
U
      6289 =C2=B1  7%    +627.6%      45763 =C2=B1  9%  softirqs.CPU68.RC=
U
      6651 =C2=B1  9%    +530.1%      41916 =C2=B1 10%  softirqs.CPU69.RC=
U
      6370 =C2=B1 13%    +593.1%      44148 =C2=B1  5%  softirqs.CPU7.RCU
     27083 =C2=B1 16%     -52.0%      13004 =C2=B1 75%  softirqs.CPU7.SCH=
ED
    106068 =C2=B1 14%     -31.0%      73147 =C2=B1  4%  softirqs.CPU7.TIM=
ER
      6287 =C2=B1  7%    +667.9%      48279 =C2=B1  8%  softirqs.CPU70.RC=
U
      7080 =C2=B1 15%    +610.7%      50320 =C2=B1  6%  softirqs.CPU71.RC=
U
      6229 =C2=B1 13%    +584.6%      42645 =C2=B1  5%  softirqs.CPU72.RC=
U
      5633 =C2=B1  6%    +697.9%      44944 =C2=B1 10%  softirqs.CPU73.RC=
U
      5720 =C2=B1  8%    +681.2%      44689 =C2=B1 11%  softirqs.CPU74.RC=
U
      5614 =C2=B1  7%    +704.3%      45154 =C2=B1  8%  softirqs.CPU75.RC=
U
      5672 =C2=B1  4%    +696.8%      45199 =C2=B1  9%  softirqs.CPU76.RC=
U
      5717 =C2=B1  6%    +620.1%      41171 =C2=B1 12%  softirqs.CPU77.RC=
U
      5741 =C2=B1  5%    +631.2%      41981 =C2=B1  9%  softirqs.CPU78.RC=
U
      5634 =C2=B1  6%    +712.8%      45795 =C2=B1  9%  softirqs.CPU79.RC=
U
      6579 =C2=B1  7%    +547.3%      42586 =C2=B1  9%  softirqs.CPU8.RCU
      5515 =C2=B1  5%    +688.6%      43491 =C2=B1  7%  softirqs.CPU80.RC=
U
     29701 =C2=B1  5%     -47.5%      15599 =C2=B1 75%  softirqs.CPU80.SC=
HED
      6523 =C2=B1 25%    +548.7%      42319 =C2=B1  6%  softirqs.CPU81.RC=
U
      5764 =C2=B1  3%    +653.2%      43416 =C2=B1 11%  softirqs.CPU82.RC=
U
      5590 =C2=B1  4%    +695.1%      44452 =C2=B1  8%  softirqs.CPU83.RC=
U
      5667 =C2=B1  5%    +715.9%      46238 =C2=B1 14%  softirqs.CPU84.RC=
U
      5880 =C2=B1  9%    +647.1%      43931 =C2=B1  8%  softirqs.CPU85.RC=
U
      5775 =C2=B1  3%    +640.7%      42780 =C2=B1 11%  softirqs.CPU86.RC=
U
      6126 =C2=B1 10%    +573.2%      41245 =C2=B1 11%  softirqs.CPU87.RC=
U
      5728 =C2=B1  3%    +652.8%      43124 =C2=B1  7%  softirqs.CPU88.RC=
U
      5617 =C2=B1  2%    +683.2%      43993 =C2=B1  9%  softirqs.CPU89.RC=
U
      6054 =C2=B1  7%    +561.2%      40033 =C2=B1  3%  softirqs.CPU9.RCU
     29041 =C2=B1  5%     -13.7%      25050 =C2=B1 13%  softirqs.CPU9.SCH=
ED
      5813 =C2=B1  5%    +667.4%      44609 =C2=B1  8%  softirqs.CPU90.RC=
U
      6071 =C2=B1 12%    +620.2%      43727 =C2=B1  9%  softirqs.CPU91.RC=
U
      6124 =C2=B1  5%    +615.8%      43837 =C2=B1  9%  softirqs.CPU92.RC=
U
      5891 =C2=B1  8%    +626.8%      42815 =C2=B1  9%  softirqs.CPU93.RC=
U
      6384 =C2=B1 26%    +594.5%      44342 =C2=B1  7%  softirqs.CPU94.RC=
U
      5795 =C2=B1  9%    +666.8%      44438 =C2=B1  8%  softirqs.CPU95.RC=
U
    606775 =C2=B1  3%    +600.3%    4249152        softirqs.RCU
   1736128 =C2=B1  3%     -11.4%    1538649        softirqs.SCHED
     64.54 =C2=B1  7%     -63.2        1.32 =C2=B1 19%  perf-profile.call=
trace.cycles-pp.__do_fault.__handle_mm_fault.handle_mm_fault.__do_page_fa=
ult.do_page_fault
     64.51 =C2=B1  7%     -63.2        1.30 =C2=B1 19%  perf-profile.call=
trace.cycles-pp.ext4_dax_huge_fault.__do_fault.__handle_mm_fault.handle_m=
m_fault.__do_page_fault
     64.68 =C2=B1  7%     -60.8        3.91 =C2=B1 19%  perf-profile.call=
trace.cycles-pp.__handle_mm_fault.handle_mm_fault.__do_page_fault.do_page=
_fault.page_fault
     64.79 =C2=B1  7%     -60.7        4.05 =C2=B1 19%  perf-profile.call=
trace.cycles-pp.handle_mm_fault.__do_page_fault.do_page_fault.page_fault
     65.11 =C2=B1  7%     -60.6        4.46 =C2=B1 18%  perf-profile.call=
trace.cycles-pp.page_fault
     65.02 =C2=B1  7%     -60.6        4.37 =C2=B1 18%  perf-profile.call=
trace.cycles-pp.__do_page_fault.do_page_fault.page_fault
     65.07 =C2=B1  7%     -60.6        4.44 =C2=B1 18%  perf-profile.call=
trace.cycles-pp.do_page_fault.page_fault
     54.60 =C2=B1 10%     -53.7        0.93 =C2=B1 18%  perf-profile.call=
trace.cycles-pp.dax_iomap_pte_fault.ext4_dax_huge_fault.__do_fault.__hand=
le_mm_fault.handle_mm_fault
     49.90 =C2=B1 12%     -49.7        0.18 =C2=B1173%  perf-profile.call=
trace.cycles-pp.__vm_insert_mixed.dax_iomap_pte_fault.ext4_dax_huge_fault=
.__do_fault.__handle_mm_fault
     49.36 =C2=B1 12%     -49.2        0.17 =C2=B1173%  perf-profile.call=
trace.cycles-pp.track_pfn_insert.__vm_insert_mixed.dax_iomap_pte_fault.ex=
t4_dax_huge_fault.__do_fault
     49.36 =C2=B1 12%     -49.2        0.17 =C2=B1173%  perf-profile.call=
trace.cycles-pp.lookup_memtype.track_pfn_insert.__vm_insert_mixed.dax_iom=
ap_pte_fault.ext4_dax_huge_fault
     47.65 =C2=B1 12%     -47.7        0.00        perf-profile.calltrace=
.cycles-pp._raw_spin_lock.lookup_memtype.track_pfn_insert.__vm_insert_mix=
ed.dax_iomap_pte_fault
     47.09 =C2=B1 12%     -47.1        0.00        perf-profile.calltrace=
.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.lookup_memtype=
.track_pfn_insert.__vm_insert_mixed
      6.22 =C2=B1 21%      -6.2        0.00        perf-profile.calltrace=
.cycles-pp.jbd2__journal_start.ext4_dax_huge_fault.__do_fault.__handle_mm=
_fault.handle_mm_fault
      6.11 =C2=B1 21%      -6.1        0.00        perf-profile.calltrace=
.cycles-pp.start_this_handle.jbd2__journal_start.ext4_dax_huge_fault.__do=
_fault.__handle_mm_fault
      0.70 =C2=B1 24%      +0.6        1.31 =C2=B1 35%  perf-profile.call=
trace.cycles-pp.cpuidle_enter.do_idle.cpu_startup_entry.start_kernel.seco=
ndary_startup_64
      0.70 =C2=B1 24%      +0.6        1.31 =C2=B1 35%  perf-profile.call=
trace.cycles-pp.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_ent=
ry.start_kernel
      0.70 =C2=B1 24%      +0.6        1.33 =C2=B1 36%  perf-profile.call=
trace.cycles-pp.do_idle.cpu_startup_entry.start_kernel.secondary_startup_=
64
      0.70 =C2=B1 24%      +0.6        1.33 =C2=B1 36%  perf-profile.call=
trace.cycles-pp.cpu_startup_entry.start_kernel.secondary_startup_64
      0.70 =C2=B1 24%      +0.6        1.33 =C2=B1 36%  perf-profile.call=
trace.cycles-pp.start_kernel.secondary_startup_64
      0.00            +0.9        0.91 =C2=B1 28%  perf-profile.calltrace=
.cycles-pp.__mark_inode_dirty.generic_update_time.file_update_time.ext4_d=
ax_huge_fault.__handle_mm_fault
      0.00            +0.9        0.91 =C2=B1 27%  perf-profile.calltrace=
.cycles-pp.generic_update_time.file_update_time.ext4_dax_huge_fault.__han=
dle_mm_fault.handle_mm_fault
      0.00            +0.9        0.95 =C2=B1 27%  perf-profile.calltrace=
.cycles-pp.file_update_time.ext4_dax_huge_fault.__handle_mm_fault.handle_=
mm_fault.__do_page_fault
      0.00            +1.2        1.17 =C2=B1 19%  perf-profile.calltrace=
.cycles-pp.dax_iomap_pmd_fault.ext4_dax_huge_fault.__handle_mm_fault.hand=
le_mm_fault.__do_page_fault
      0.00            +2.4        2.39 =C2=B1 24%  perf-profile.calltrace=
.cycles-pp.ext4_dax_huge_fault.__handle_mm_fault.handle_mm_fault.__do_pag=
e_fault.do_page_fault
      0.10 =C2=B1200%     +21.7       21.78 =C2=B1 13%  perf-profile.call=
trace.cycles-pp.get_io_u
     33.25 =C2=B1 15%     +34.9       68.17 =C2=B1  4%  perf-profile.call=
trace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_=
startup_entry
     32.74 =C2=B1 15%     +35.6       68.39 =C2=B1  4%  perf-profile.call=
trace.cycles-pp.cpuidle_enter_state.cpuidle_enter.do_idle.cpu_startup_ent=
ry.start_secondary
     32.75 =C2=B1 15%     +35.7       68.42 =C2=B1  4%  perf-profile.call=
trace.cycles-pp.cpuidle_enter.do_idle.cpu_startup_entry.start_secondary.s=
econdary_startup_64
     32.84 =C2=B1 15%     +36.4       69.27 =C2=B1  4%  perf-profile.call=
trace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_start=
up_64
     32.84 =C2=B1 15%     +36.4       69.27 =C2=B1  4%  perf-profile.call=
trace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64
     32.84 =C2=B1 15%     +36.4       69.27 =C2=B1  4%  perf-profile.call=
trace.cycles-pp.start_secondary.secondary_startup_64
     33.54 =C2=B1 15%     +37.1       70.60 =C2=B1  4%  perf-profile.call=
trace.cycles-pp.secondary_startup_64
     64.54 =C2=B1  7%     -63.2        1.33 =C2=B1 19%  perf-profile.chil=
dren.cycles-pp.__do_fault
     64.54 =C2=B1  7%     -60.8        3.70 =C2=B1 19%  perf-profile.chil=
dren.cycles-pp.ext4_dax_huge_fault
     64.68 =C2=B1  7%     -60.7        3.95 =C2=B1 19%  perf-profile.chil=
dren.cycles-pp.__handle_mm_fault
     64.80 =C2=B1  7%     -60.7        4.09 =C2=B1 19%  perf-profile.chil=
dren.cycles-pp.handle_mm_fault
     65.02 =C2=B1  7%     -60.6        4.42 =C2=B1 18%  perf-profile.chil=
dren.cycles-pp.__do_page_fault
     65.13 =C2=B1  7%     -60.6        4.53 =C2=B1 18%  perf-profile.chil=
dren.cycles-pp.page_fault
     65.08 =C2=B1  7%     -60.6        4.50 =C2=B1 18%  perf-profile.chil=
dren.cycles-pp.do_page_fault
     54.61 =C2=B1 10%     -53.7        0.93 =C2=B1 18%  perf-profile.chil=
dren.cycles-pp.dax_iomap_pte_fault
     49.90 =C2=B1 12%     -49.4        0.52 =C2=B1 21%  perf-profile.chil=
dren.cycles-pp.__vm_insert_mixed
     49.36 =C2=B1 12%     -48.4        0.93 =C2=B1 19%  perf-profile.chil=
dren.cycles-pp.lookup_memtype
     49.36 =C2=B1 12%     -48.4        0.94 =C2=B1 19%  perf-profile.chil=
dren.cycles-pp.track_pfn_insert
     48.14 =C2=B1 12%     -47.9        0.25 =C2=B1 20%  perf-profile.chil=
dren.cycles-pp._raw_spin_lock
     47.11 =C2=B1 12%     -47.1        0.05 =C2=B1 59%  perf-profile.chil=
dren.cycles-pp.native_queued_spin_lock_slowpath
      6.40 =C2=B1 20%      -6.0        0.37 =C2=B1 39%  perf-profile.chil=
dren.cycles-pp.start_this_handle
      6.52 =C2=B1 19%      -6.0        0.49 =C2=B1 35%  perf-profile.chil=
dren.cycles-pp.jbd2__journal_start
      4.07 =C2=B1 21%      -3.7        0.40 =C2=B1 21%  perf-profile.chil=
dren.cycles-pp.ext4_iomap_begin
      3.11 =C2=B1 17%      -2.8        0.30 =C2=B1 29%  perf-profile.chil=
dren.cycles-pp.__ext4_journal_stop
      2.94 =C2=B1 17%      -2.7        0.28 =C2=B1 30%  perf-profile.chil=
dren.cycles-pp.jbd2_journal_stop
      2.65 =C2=B1 16%      -2.2        0.47 =C2=B1 30%  perf-profile.chil=
dren.cycles-pp._raw_read_lock
      1.90 =C2=B1 23%      -1.9        0.03 =C2=B1100%  perf-profile.chil=
dren.cycles-pp.jbd2_transaction_committed
      1.78 =C2=B1 20%      -1.6        0.17 =C2=B1 19%  perf-profile.chil=
dren.cycles-pp.__ext4_journal_start_sb
      1.75 =C2=B1 20%      -1.6        0.15 =C2=B1 19%  perf-profile.chil=
dren.cycles-pp.ext4_journal_check_start
      1.52 =C2=B1 19%      -1.5        0.04 =C2=B1100%  perf-profile.chil=
dren.cycles-pp.add_transaction_credits
      1.51 =C2=B1  8%      -0.9        0.61 =C2=B1 21%  perf-profile.chil=
dren.cycles-pp.find_next_iomem_res
      1.53 =C2=B1  8%      -0.9        0.64 =C2=B1 21%  perf-profile.chil=
dren.cycles-pp.pat_pagerange_is_ram
      1.53 =C2=B1  8%      -0.9        0.63 =C2=B1 21%  perf-profile.chil=
dren.cycles-pp.walk_system_ram_range
      0.14 =C2=B1  7%      -0.1        0.06 =C2=B1 59%  perf-profile.chil=
dren.cycles-pp.dax_insert_entry
      0.11 =C2=B1  6%      -0.1        0.04 =C2=B1 58%  perf-profile.chil=
dren.cycles-pp.dax_unlock_entry
      0.09 =C2=B1  9%      -0.1        0.03 =C2=B1100%  perf-profile.chil=
dren.cycles-pp._raw_spin_lock_irq
      0.15 =C2=B1 13%      -0.1        0.10 =C2=B1 15%  perf-profile.chil=
dren.cycles-pp.rbt_memtype_lookup
      0.07 =C2=B1  5%      -0.0        0.03 =C2=B1100%  perf-profile.chil=
dren.cycles-pp.___might_sleep
      0.09 =C2=B1 11%      +0.0        0.12 =C2=B1 13%  perf-profile.chil=
dren.cycles-pp.ext4_es_lookup_extent
      0.07 =C2=B1 10%      +0.0        0.12 =C2=B1 21%  perf-profile.chil=
dren.cycles-pp.kmem_cache_alloc
      0.02 =C2=B1123%      +0.0        0.07 =C2=B1 19%  perf-profile.chil=
dren.cycles-pp.__sb_start_write
      0.02 =C2=B1122%      +0.1        0.07 =C2=B1  5%  perf-profile.chil=
dren.cycles-pp.serial8250_console_putchar
      0.02 =C2=B1122%      +0.1        0.07 =C2=B1  5%  perf-profile.chil=
dren.cycles-pp.wait_for_xmitr
      0.02 =C2=B1122%      +0.1        0.08 =C2=B1 11%  perf-profile.chil=
dren.cycles-pp.serial8250_console_write
      0.02 =C2=B1122%      +0.1        0.08 =C2=B1 11%  perf-profile.chil=
dren.cycles-pp.uart_console_write
      0.02 =C2=B1123%      +0.1        0.08 =C2=B1 10%  perf-profile.chil=
dren.cycles-pp.irq_work_run_list
      0.02 =C2=B1123%      +0.1        0.08 =C2=B1 10%  perf-profile.chil=
dren.cycles-pp.console_unlock
      0.00            +0.1        0.06 =C2=B1 14%  perf-profile.children.=
cycles-pp.read
      0.00            +0.1        0.06 =C2=B1 14%  perf-profile.children.=
cycles-pp.__libc_fork
      0.00            +0.1        0.06 =C2=B1 11%  perf-profile.children.=
cycles-pp.search_binary_handler
      0.00            +0.1        0.06 =C2=B1 11%  perf-profile.children.=
cycles-pp.load_elf_binary
      0.01 =C2=B1200%      +0.1        0.07 =C2=B1 31%  perf-profile.chil=
dren.cycles-pp.io_serial_in
      0.00            +0.1        0.07 =C2=B1 17%  perf-profile.children.=
cycles-pp.exit_mmap
      0.00            +0.1        0.07 =C2=B1 19%  perf-profile.children.=
cycles-pp.ext4_inode_csum_set
      0.00            +0.1        0.07 =C2=B1 12%  perf-profile.children.=
cycles-pp.mmput
      0.16 =C2=B1 21%      +0.1        0.22 =C2=B1 14%  perf-profile.chil=
dren.cycles-pp.ext4_map_blocks
      0.00            +0.1        0.07 =C2=B1  5%  perf-profile.children.=
cycles-pp.irq_work_interrupt
      0.00            +0.1        0.07 =C2=B1  5%  perf-profile.children.=
cycles-pp.smp_irq_work_interrupt
      0.00            +0.1        0.07 =C2=B1  5%  perf-profile.children.=
cycles-pp.irq_work_run
      0.00            +0.1        0.07 =C2=B1  5%  perf-profile.children.=
cycles-pp.printk
      0.00            +0.1        0.07 =C2=B1  5%  perf-profile.children.=
cycles-pp.vprintk_emit
      0.00            +0.1        0.07 =C2=B1 14%  perf-profile.children.=
cycles-pp.__schedule
      0.00            +0.1        0.08 =C2=B1 19%  perf-profile.children.=
cycles-pp.__wake_up_common_lock
      0.02 =C2=B1200%      +0.1        0.10 =C2=B1 24%  perf-profile.chil=
dren.cycles-pp.ext4_data_block_valid
      0.00            +0.1        0.09 =C2=B1 19%  perf-profile.children.=
cycles-pp.native_write_msr
      0.00            +0.1        0.09 =C2=B1 21%  perf-profile.children.=
cycles-pp.kthread
      0.00            +0.1        0.09 =C2=B1 12%  perf-profile.children.=
cycles-pp.__do_execve_file
      0.00            +0.1        0.09 =C2=B1 12%  perf-profile.children.=
cycles-pp.execve
      0.00            +0.1        0.09 =C2=B1 24%  perf-profile.children.=
cycles-pp.ret_from_fork
      0.10 =C2=B1  7%      +0.1        0.19 =C2=B1 15%  perf-profile.chil=
dren.cycles-pp.__perf_sw_event
      0.00            +0.1        0.09 =C2=B1 13%  perf-profile.children.=
cycles-pp.__x64_sys_execve
      0.00            +0.1        0.09 =C2=B1 28%  perf-profile.children.=
cycles-pp.vmacache_find
      0.00            +0.1        0.09 =C2=B1 37%  perf-profile.children.=
cycles-pp.__run_perf_stat
      0.00            +0.1        0.09 =C2=B1 37%  perf-profile.children.=
cycles-pp.cmd_stat
      0.00            +0.1        0.09 =C2=B1 37%  perf-profile.children.=
cycles-pp.process_interval
      0.00            +0.1        0.09 =C2=B1 37%  perf-profile.children.=
cycles-pp.read_counters
      0.00            +0.1        0.10 =C2=B1 27%  perf-profile.children.=
cycles-pp.ext4_data_block_valid_rcu
      0.00            +0.1        0.10 =C2=B1 24%  perf-profile.children.=
cycles-pp.find_vma
      0.00            +0.1        0.10 =C2=B1 11%  perf-profile.children.=
cycles-pp.perf_mux_hrtimer_handler
      0.00            +0.1        0.10 =C2=B1 29%  perf-profile.children.=
cycles-pp.get_next_timer_interrupt
      0.07 =C2=B1  9%      +0.1        0.18 =C2=B1 15%  perf-profile.chil=
dren.cycles-pp.___perf_sw_event
      0.00            +0.1        0.11 =C2=B1 33%  perf-profile.children.=
cycles-pp.do_wait
      0.05            +0.1        0.18 =C2=B1 23%  perf-profile.children.=
cycles-pp.dax_wake_entry
      0.00            +0.1        0.13 =C2=B1 31%  perf-profile.children.=
cycles-pp.__do_sys_wait4
      0.00            +0.1        0.13 =C2=B1 31%  perf-profile.children.=
cycles-pp.kernel_wait4
      0.00            +0.1        0.13 =C2=B1 31%  perf-profile.children.=
cycles-pp.__waitpid
      0.00            +0.1        0.14 =C2=B1 28%  perf-profile.children.=
cycles-pp.vfs_read
      0.42 =C2=B1  9%      +0.1        0.56 =C2=B1  6%  perf-profile.chil=
dren.cycles-pp.native_irq_return_iret
      0.00            +0.1        0.14 =C2=B1 36%  perf-profile.children.=
cycles-pp.update_load_avg
      0.00            +0.1        0.14 =C2=B1 29%  perf-profile.children.=
cycles-pp.ksys_read
      0.11 =C2=B1 10%      +0.1        0.25 =C2=B1 23%  perf-profile.chil=
dren.cycles-pp.ext4_mark_iloc_dirty
      0.00            +0.1        0.14 =C2=B1 23%  perf-profile.children.=
cycles-pp.__ext4_get_inode_loc
      0.00            +0.1        0.15 =C2=B1 30%  perf-profile.children.=
cycles-pp._raw_spin_lock_irqsave
      0.14 =C2=B1  9%      +0.2        0.29 =C2=B1 16%  perf-profile.chil=
dren.cycles-pp.grab_mapping_entry
      0.05 =C2=B1  7%      +0.2        0.21 =C2=B1 17%  perf-profile.chil=
dren.cycles-pp.get_unlocked_entry
      0.05 =C2=B1 52%      +0.2        0.22 =C2=B1 49%  perf-profile.chil=
dren.cycles-pp.writen
      0.05 =C2=B1 52%      +0.2        0.22 =C2=B1 49%  perf-profile.chil=
dren.cycles-pp.__GI___libc_write
      0.05 =C2=B1 52%      +0.2        0.22 =C2=B1 47%  perf-profile.chil=
dren.cycles-pp.record__pushfn
      0.05 =C2=B1 55%      +0.2        0.23 =C2=B1 47%  perf-profile.chil=
dren.cycles-pp.perf_mmap__push
      0.02 =C2=B1122%      +0.2        0.20 =C2=B1 47%  perf-profile.chil=
dren.cycles-pp.__generic_file_write_iter
      0.02 =C2=B1123%      +0.2        0.20 =C2=B1 47%  perf-profile.chil=
dren.cycles-pp.generic_perform_write
      0.05 =C2=B1 52%      +0.2        0.23 =C2=B1 42%  perf-profile.chil=
dren.cycles-pp.vfs_write
      0.02 =C2=B1122%      +0.2        0.21 =C2=B1 48%  perf-profile.chil=
dren.cycles-pp.generic_file_write_iter
      0.04 =C2=B1 83%      +0.2        0.22 =C2=B1 44%  perf-profile.chil=
dren.cycles-pp.new_sync_write
      0.05 =C2=B1 55%      +0.2        0.24 =C2=B1 48%  perf-profile.chil=
dren.cycles-pp.record__mmap_read_evlist
      0.05 =C2=B1 52%      +0.2        0.23 =C2=B1 43%  perf-profile.chil=
dren.cycles-pp.ksys_write
      0.00            +0.2        0.20 =C2=B1 22%  perf-profile.children.=
cycles-pp.ext4_reserve_inode_write
      0.00            +0.2        0.20 =C2=B1 20%  perf-profile.children.=
cycles-pp.xas_find_conflict
      0.01 =C2=B1200%      +0.2        0.23 =C2=B1 36%  perf-profile.chil=
dren.cycles-pp.tick_nohz_next_event
      0.08 =C2=B1 18%      +0.2        0.31 =C2=B1 48%  perf-profile.chil=
dren.cycles-pp.cmd_record
      0.01 =C2=B1200%      +0.3        0.28 =C2=B1 35%  perf-profile.chil=
dren.cycles-pp.tick_nohz_get_sleep_length
      0.09 =C2=B1 16%      +0.3        0.40 =C2=B1 31%  perf-profile.chil=
dren.cycles-pp.__libc_start_main
      0.09 =C2=B1 16%      +0.3        0.40 =C2=B1 31%  perf-profile.chil=
dren.cycles-pp.main
      0.09 =C2=B1 16%      +0.3        0.40 =C2=B1 31%  perf-profile.chil=
dren.cycles-pp.run_builtin
      0.61 =C2=B1 10%      +0.3        0.94 =C2=B1 26%  perf-profile.chil=
dren.cycles-pp.__mark_inode_dirty
      0.45 =C2=B1  9%      +0.3        0.78 =C2=B1 27%  perf-profile.chil=
dren.cycles-pp.ext4_dirty_inode
      0.13 =C2=B1 11%      +0.3        0.47 =C2=B1 23%  perf-profile.chil=
dren.cycles-pp.ext4_mark_inode_dirty
      0.08 =C2=B1 23%      +0.3        0.42 =C2=B1 38%  perf-profile.chil=
dren.cycles-pp.task_tick_fair
      0.63 =C2=B1 10%      +0.4        0.98 =C2=B1 26%  perf-profile.chil=
dren.cycles-pp.file_update_time
      0.57 =C2=B1 10%      +0.4        0.93 =C2=B1 27%  perf-profile.chil=
dren.cycles-pp.generic_update_time
      0.00            +0.5        0.46 =C2=B1 20%  perf-profile.children.=
cycles-pp.vmf_insert_pfn_pmd
      0.10 =C2=B1 27%      +0.5        0.57 =C2=B1 40%  perf-profile.chil=
dren.cycles-pp.scheduler_tick
      0.06 =C2=B1 54%      +0.5        0.58 =C2=B1 34%  perf-profile.chil=
dren.cycles-pp.menu_select
      0.70 =C2=B1 24%      +0.6        1.33 =C2=B1 36%  perf-profile.chil=
dren.cycles-pp.start_kernel
      0.19 =C2=B1 36%      +0.7        0.94 =C2=B1 42%  perf-profile.chil=
dren.cycles-pp.update_process_times
      0.11 =C2=B1 11%      +0.8        0.91 =C2=B1 15%  perf-profile.chil=
dren.cycles-pp.do_syscall_64
      0.19 =C2=B1 36%      +0.8        0.99 =C2=B1 42%  perf-profile.chil=
dren.cycles-pp.tick_sched_handle
      0.11 =C2=B1 11%      +0.8        0.91 =C2=B1 15%  perf-profile.chil=
dren.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.22 =C2=B1 32%      +0.8        1.05 =C2=B1 42%  perf-profile.chil=
dren.cycles-pp.tick_sched_timer
      0.26 =C2=B1 29%      +1.0        1.25 =C2=B1 38%  perf-profile.chil=
dren.cycles-pp.__hrtimer_run_queues
      0.00            +1.2        1.17 =C2=B1 19%  perf-profile.children.=
cycles-pp.dax_iomap_pmd_fault
      0.42 =C2=B1 23%      +1.4        1.80 =C2=B1 40%  perf-profile.chil=
dren.cycles-pp.hrtimer_interrupt
      0.52 =C2=B1 26%      +2.1        2.58 =C2=B1 41%  perf-profile.chil=
dren.cycles-pp.smp_apic_timer_interrupt
      0.56 =C2=B1 25%      +2.1        2.69 =C2=B1 40%  perf-profile.chil=
dren.cycles-pp.apic_timer_interrupt
      0.46 =C2=B1  8%     +21.4       21.84 =C2=B1 13%  perf-profile.chil=
dren.cycles-pp.get_io_u
     33.24 =C2=B1 15%     +34.9       68.17 =C2=B1  4%  perf-profile.chil=
dren.cycles-pp.intel_idle
     33.45 =C2=B1 15%     +36.3       69.73 =C2=B1  4%  perf-profile.chil=
dren.cycles-pp.cpuidle_enter_state
     33.45 =C2=B1 15%     +36.3       69.74 =C2=B1  4%  perf-profile.chil=
dren.cycles-pp.cpuidle_enter
     32.84 =C2=B1 15%     +36.4       69.27 =C2=B1  4%  perf-profile.chil=
dren.cycles-pp.start_secondary
     33.54 =C2=B1 15%     +37.1       70.60 =C2=B1  4%  perf-profile.chil=
dren.cycles-pp.secondary_startup_64
     33.54 =C2=B1 15%     +37.1       70.60 =C2=B1  4%  perf-profile.chil=
dren.cycles-pp.cpu_startup_entry
     33.55 =C2=B1 15%     +37.1       70.60 =C2=B1  4%  perf-profile.chil=
dren.cycles-pp.do_idle
     46.84 =C2=B1 12%     -46.8        0.05 =C2=B1 59%  perf-profile.self=
.cycles-pp.native_queued_spin_lock_slowpath
      3.44 =C2=B1 21%      -3.3        0.13 =C2=B1 47%  perf-profile.self=
.cycles-pp.start_this_handle
      2.89 =C2=B1 17%      -2.7        0.17 =C2=B1 39%  perf-profile.self=
.cycles-pp.jbd2_journal_stop
      2.63 =C2=B1 16%      -2.2        0.46 =C2=B1 31%  perf-profile.self=
.cycles-pp._raw_read_lock
      1.70 =C2=B1 20%      -1.6        0.14 =C2=B1 22%  perf-profile.self=
.cycles-pp.ext4_journal_check_start
      1.52 =C2=B1 20%      -1.5        0.04 =C2=B1100%  perf-profile.self=
.cycles-pp.add_transaction_credits
      1.02 =C2=B1  6%      -0.8        0.22 =C2=B1 23%  perf-profile.self=
.cycles-pp._raw_spin_lock
      1.06 =C2=B1  9%      -0.7        0.39 =C2=B1 18%  perf-profile.self=
.cycles-pp.find_next_iomem_res
      0.08 =C2=B1 17%      -0.1        0.03 =C2=B1100%  perf-profile.self=
.cycles-pp.ext4_iomap_begin
      0.15 =C2=B1 11%      -0.1        0.10 =C2=B1 15%  perf-profile.self=
.cycles-pp.rbt_memtype_lookup
      0.06 =C2=B1  7%      -0.0        0.03 =C2=B1100%  perf-profile.self=
.cycles-pp.___might_sleep
      0.00            +0.1        0.06 =C2=B1 11%  perf-profile.self.cycl=
es-pp.ext4_es_lookup_extent
      0.00            +0.1        0.09 =C2=B1 19%  perf-profile.self.cycl=
es-pp.native_write_msr
      0.04 =C2=B1 50%      +0.1        0.13 =C2=B1 29%  perf-profile.self=
.cycles-pp.ext4_mark_iloc_dirty
      0.06 =C2=B1  8%      +0.1        0.14 =C2=B1 18%  perf-profile.self=
.cycles-pp.___perf_sw_event
      0.00            +0.1        0.09 =C2=B1 24%  perf-profile.self.cycl=
es-pp.ext4_data_block_valid_rcu
      0.00            +0.1        0.09 =C2=B1 28%  perf-profile.self.cycl=
es-pp.vmacache_find
      0.00            +0.1        0.10 =C2=B1 22%  perf-profile.self.cycl=
es-pp.kmem_cache_alloc
      0.00            +0.1        0.12 =C2=B1 27%  perf-profile.self.cycl=
es-pp._raw_spin_lock_irqsave
      0.05            +0.1        0.18 =C2=B1 23%  perf-profile.self.cycl=
es-pp.dax_wake_entry
      0.42 =C2=B1  9%      +0.1        0.56 =C2=B1  6%  perf-profile.self=
.cycles-pp.native_irq_return_iret
      0.00            +0.2        0.16 =C2=B1 18%  perf-profile.self.cycl=
es-pp.xas_find_conflict
      0.00            +0.2        0.18 =C2=B1 29%  perf-profile.self.cycl=
es-pp.menu_select
      0.45 =C2=B1  9%     +21.1       21.52 =C2=B1 14%  perf-profile.self=
.cycles-pp.get_io_u
     33.24 =C2=B1 15%     +34.9       68.17 =C2=B1  4%  perf-profile.self=
.cycles-pp.intel_idle





Disclaimer:
Results have been estimated based on internal Intel analysis and are prov=
ided
for informational purposes only. Any difference in system hardware or sof=
tware
design or configuration may affect actual performance.


Thanks,
Rong Chen


--GBuTPvBEOL0MYPgd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-5.4.0-rc4-00001-ga70e8083a91b1"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 5.4.0-rc4 Kernel Configuration
#

#
# Compiler: gcc-7 (Debian 7.4.0-14) 7.4.0
#
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=70400
CONFIG_CLANG_VERSION=0
CONFIG_CC_CAN_LINK=y
CONFIG_CC_HAS_ASM_GOTO=y
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_CC_HAS_WARN_MAYBE_UNINITIALIZED=y
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_EXTABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_COMPILE_TEST is not set
# CONFIG_HEADER_TEST is not set
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_BUILD_SALT=""
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
CONFIG_KERNEL_GZIP=y
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
CONFIG_POSIX_MQUEUE=y
CONFIG_POSIX_MQUEUE_SYSCTL=y
CONFIG_CROSS_MEMORY_ATTACH=y
CONFIG_USELIB=y
CONFIG_AUDIT=y
CONFIG_HAVE_ARCH_AUDITSYSCALL=y
CONFIG_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_GENERIC_IRQ_MIGRATION=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_SIM=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_MSI_IRQ=y
CONFIG_GENERIC_MSI_IRQ_DOMAIN=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
# CONFIG_GENERIC_IRQ_DEBUGFS is not set
# end of IRQ subsystem

CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_DATA=y
CONFIG_ARCH_CLOCKSOURCE_INIT=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
# CONFIG_NO_HZ_IDLE is not set
CONFIG_NO_HZ_FULL=y
CONFIG_CONTEXT_TRACKING=y
# CONFIG_CONTEXT_TRACKING_FORCE is not set
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y
# end of Timers subsystem

# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y

#
# CPU/Task time and stats accounting
#
CONFIG_VIRT_CPU_ACCOUNTING=y
CONFIG_VIRT_CPU_ACCOUNTING_GEN=y
# CONFIG_IRQ_TIME_ACCOUNTING is not set
CONFIG_HAVE_SCHED_AVG_IRQ=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
CONFIG_TASKSTATS=y
CONFIG_TASK_DELAY_ACCT=y
CONFIG_TASK_XACCT=y
CONFIG_TASK_IO_ACCOUNTING=y
# CONFIG_PSI is not set
# end of CPU/Task time and stats accounting

CONFIG_CPU_ISOLATION=y

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_RCU_NOCB_CPU=y
# end of RCU Subsystem

CONFIG_BUILD_BIN2C=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_IKHEADERS is not set
CONFIG_LOG_BUF_SHIFT=20
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y

#
# Scheduler features
#
# end of Scheduler features

CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_ARCH_SUPPORTS_INT128=y
CONFIG_NUMA_BALANCING=y
CONFIG_NUMA_BALANCING_DEFAULT_ENABLED=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
CONFIG_MEMCG=y
CONFIG_MEMCG_SWAP=y
CONFIG_MEMCG_SWAP_ENABLED=y
CONFIG_MEMCG_KMEM=y
CONFIG_BLK_CGROUP=y
CONFIG_CGROUP_WRITEBACK=y
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_CFS_BANDWIDTH=y
CONFIG_RT_GROUP_SCHED=y
CONFIG_CGROUP_PIDS=y
CONFIG_CGROUP_RDMA=y
CONFIG_CGROUP_FREEZER=y
CONFIG_CGROUP_HUGETLB=y
CONFIG_CPUSETS=y
CONFIG_PROC_PID_CPUSET=y
CONFIG_CGROUP_DEVICE=y
CONFIG_CGROUP_CPUACCT=y
CONFIG_CGROUP_PERF=y
CONFIG_CGROUP_BPF=y
# CONFIG_CGROUP_DEBUG is not set
CONFIG_SOCK_CGROUP_DATA=y
CONFIG_NAMESPACES=y
CONFIG_UTS_NS=y
CONFIG_IPC_NS=y
CONFIG_USER_NS=y
CONFIG_PID_NS=y
CONFIG_NET_NS=y
CONFIG_CHECKPOINT_RESTORE=y
CONFIG_SCHED_AUTOGROUP=y
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
CONFIG_RD_LZMA=y
CONFIG_RD_XZ=y
CONFIG_RD_LZO=y
CONFIG_RD_LZ4=y
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_SYSCTL=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_BPF=y
CONFIG_EXPERT=y
CONFIG_UID16=y
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
CONFIG_SYSFS_SYSCALL=y
# CONFIG_SYSCTL_SYSCALL is not set
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_PRINTK_NMI=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_PCSPKR_PLATFORM=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_IO_URING=y
CONFIG_ADVISE_SYSCALLS=y
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_BPF_SYSCALL=y
CONFIG_BPF_JIT_ALWAYS_ON=y
CONFIG_USERFAULTFD=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_RSEQ=y
# CONFIG_DEBUG_RSEQ is not set
CONFIG_EMBEDDED=y
CONFIG_HAVE_PERF_EVENTS=y
# CONFIG_PC104 is not set

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# end of Kernel Performance Events And Counters

CONFIG_VM_EVENT_COUNTERS=y
CONFIG_SLUB_DEBUG=y
# CONFIG_SLUB_MEMCG_SYSFS_ON is not set
# CONFIG_COMPAT_BRK is not set
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLOB is not set
CONFIG_SLAB_MERGE_DEFAULT=y
# CONFIG_SLAB_FREELIST_RANDOM is not set
# CONFIG_SLAB_FREELIST_HARDENED is not set
# CONFIG_SHUFFLE_PAGE_ALLOCATOR is not set
CONFIG_SLUB_CPU_PARTIAL=y
CONFIG_SYSTEM_DATA_VERIFICATION=y
CONFIG_PROFILING=y
CONFIG_TRACEPOINTS=y
# end of General setup

CONFIG_64BIT=y
CONFIG_X86_64=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf64-x86-64"
CONFIG_ARCH_DEFCONFIG="arch/x86/configs/x86_64_defconfig"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=28
CONFIG_ARCH_MMAP_RND_BITS_MAX=32
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_FILTER_PGPROT=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ZONE_DMA32=y
CONFIG_AUDIT_ARCH=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_HAVE_INTEL_TXT=y
CONFIG_X86_64_SMP=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_DYNAMIC_PHYSICAL_MASK=y
CONFIG_PGTABLE_LEVELS=5
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
CONFIG_ZONE_DMA=y
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_X2APIC=y
CONFIG_X86_MPPARSE=y
# CONFIG_GOLDFISH is not set
CONFIG_RETPOLINE=y
CONFIG_X86_CPU_RESCTRL=y
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_NUMACHIP is not set
# CONFIG_X86_VSMP is not set
CONFIG_X86_UV=y
# CONFIG_X86_GOLDFISH is not set
# CONFIG_X86_INTEL_MID is not set
CONFIG_X86_INTEL_LPSS=y
CONFIG_X86_AMD_PLATFORM_DEVICE=y
CONFIG_IOSF_MBI=y
# CONFIG_IOSF_MBI_DEBUG is not set
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
CONFIG_PARAVIRT_XXL=y
# CONFIG_PARAVIRT_DEBUG is not set
CONFIG_PARAVIRT_SPINLOCKS=y
CONFIG_X86_HV_CALLBACK_VECTOR=y
CONFIG_XEN=y
CONFIG_XEN_PV=y
CONFIG_XEN_PV_SMP=y
# CONFIG_XEN_DOM0 is not set
CONFIG_XEN_PVHVM=y
CONFIG_XEN_PVHVM_SMP=y
CONFIG_XEN_512GB=y
CONFIG_XEN_SAVE_RESTORE=y
# CONFIG_XEN_DEBUG_FS is not set
# CONFIG_XEN_PVH is not set
CONFIG_KVM_GUEST=y
CONFIG_ARCH_CPUIDLE_HALTPOLL=y
# CONFIG_PVH is not set
# CONFIG_KVM_DEBUG_FS is not set
CONFIG_PARAVIRT_TIME_ACCOUNTING=y
CONFIG_PARAVIRT_CLOCK=y
# CONFIG_JAILHOUSE_GUEST is not set
# CONFIG_ACRN_GUEST is not set
# CONFIG_MK8 is not set
# CONFIG_MPSC is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
CONFIG_GENERIC_CPU=y
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=64
CONFIG_X86_DEBUGCTLMSR=y
# CONFIG_PROCESSOR_SELECT is not set
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_HYGON=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_CPU_SUP_ZHAOXIN=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_DMI=y
CONFIG_GART_IOMMU=y
# CONFIG_CALGARY_IOMMU is not set
CONFIG_MAXSMP=y
CONFIG_NR_CPUS_RANGE_BEGIN=8192
CONFIG_NR_CPUS_RANGE_END=8192
CONFIG_NR_CPUS_DEFAULT=8192
CONFIG_NR_CPUS=8192
CONFIG_SCHED_SMT=y
CONFIG_SCHED_MC=y
CONFIG_SCHED_MC_PRIO=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
CONFIG_X86_MCE=y
CONFIG_X86_MCELOG_LEGACY=y
CONFIG_X86_MCE_INTEL=y
CONFIG_X86_MCE_AMD=y
CONFIG_X86_MCE_THRESHOLD=y
CONFIG_X86_MCE_INJECT=m
CONFIG_X86_THERMAL_VECTOR=y

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=y
CONFIG_PERF_EVENTS_INTEL_RAPL=y
CONFIG_PERF_EVENTS_INTEL_CSTATE=y
# CONFIG_PERF_EVENTS_AMD_POWER is not set
# end of Performance monitoring

CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX64=y
CONFIG_X86_VSYSCALL_EMULATION=y
CONFIG_I8K=m
CONFIG_MICROCODE=y
CONFIG_MICROCODE_INTEL=y
CONFIG_MICROCODE_AMD=y
CONFIG_MICROCODE_OLD_INTERFACE=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_X86_5LEVEL=y
CONFIG_X86_DIRECT_GBPAGES=y
# CONFIG_X86_CPA_STATISTICS is not set
CONFIG_AMD_MEM_ENCRYPT=y
# CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT is not set
CONFIG_NUMA=y
CONFIG_AMD_NUMA=y
CONFIG_X86_64_ACPI_NUMA=y
CONFIG_NODES_SPAN_OTHER_NODES=y
# CONFIG_NUMA_EMU is not set
CONFIG_NODES_SHIFT=10
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ARCH_MEMORY_PROBE=y
CONFIG_ARCH_PROC_KCORE_TEXT=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
CONFIG_X86_PMEM_LEGACY_DEVICE=y
CONFIG_X86_PMEM_LEGACY=m
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
# CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK is not set
CONFIG_X86_RESERVE_LOW=64
CONFIG_MTRR=y
CONFIG_MTRR_SANITIZER=y
CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=1
CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
CONFIG_ARCH_RANDOM=y
CONFIG_X86_SMAP=y
CONFIG_X86_INTEL_UMIP=y
CONFIG_X86_INTEL_MPX=y
CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=y
CONFIG_EFI=y
CONFIG_EFI_STUB=y
CONFIG_EFI_MIXED=y
CONFIG_SECCOMP=y
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000
CONFIG_SCHED_HRTICK=y
CONFIG_KEXEC=y
CONFIG_KEXEC_FILE=y
CONFIG_ARCH_HAS_KEXEC_PURGATORY=y
# CONFIG_KEXEC_SIG is not set
CONFIG_CRASH_DUMP=y
CONFIG_KEXEC_JUMP=y
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
CONFIG_RANDOMIZE_BASE=y
CONFIG_X86_NEED_RELOCS=y
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_DYNAMIC_MEMORY_LAYOUT=y
CONFIG_RANDOMIZE_MEMORY=y
CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING=0xa
CONFIG_HOTPLUG_CPU=y
CONFIG_BOOTPARAM_HOTPLUG_CPU0=y
# CONFIG_DEBUG_HOTPLUG_CPU0 is not set
# CONFIG_COMPAT_VDSO is not set
CONFIG_LEGACY_VSYSCALL_EMULATE=y
# CONFIG_LEGACY_VSYSCALL_XONLY is not set
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
CONFIG_HAVE_LIVEPATCH=y
CONFIG_LIVEPATCH=y
# end of Processor type and features

CONFIG_ARCH_HAS_ADD_PAGES=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
CONFIG_USE_PERCPU_NUMA_NODE_ID=y
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=y
CONFIG_ARCH_ENABLE_THP_MIGRATION=y

#
# Power management and ACPI options
#
CONFIG_ARCH_HIBERNATION_HEADER=y
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
# CONFIG_SUSPEND_SKIP_SYNC is not set
CONFIG_HIBERNATE_CALLBACKS=y
CONFIG_HIBERNATION=y
CONFIG_PM_STD_PARTITION=""
CONFIG_PM_SLEEP=y
CONFIG_PM_SLEEP_SMP=y
# CONFIG_PM_AUTOSLEEP is not set
# CONFIG_PM_WAKELOCKS is not set
CONFIG_PM=y
CONFIG_PM_DEBUG=y
CONFIG_PM_ADVANCED_DEBUG=y
# CONFIG_PM_TEST_SUSPEND is not set
CONFIG_PM_SLEEP_DEBUG=y
# CONFIG_DPM_WATCHDOG is not set
CONFIG_PM_TRACE=y
CONFIG_PM_TRACE_RTC=y
CONFIG_PM_CLK=y
# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
# CONFIG_ENERGY_MODEL is not set
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=y
CONFIG_ACPI_LPIT=y
CONFIG_ACPI_SLEEP=y
# CONFIG_ACPI_PROCFS_POWER is not set
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
CONFIG_ACPI_EC_DEBUGFS=m
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=m
CONFIG_ACPI_FAN=y
# CONFIG_ACPI_TAD is not set
CONFIG_ACPI_DOCK=y
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_CPPC_LIB=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_IPMI=m
CONFIG_ACPI_HOTPLUG_CPU=y
CONFIG_ACPI_PROCESSOR_AGGREGATOR=m
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_NUMA=y
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_PCI_SLOT=y
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_MEMORY=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
CONFIG_ACPI_SBS=m
CONFIG_ACPI_HED=y
CONFIG_ACPI_CUSTOM_METHOD=m
CONFIG_ACPI_BGRT=y
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
CONFIG_ACPI_NFIT=m
# CONFIG_NFIT_SECURITY_DEBUG is not set
# CONFIG_ACPI_HMAT is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
CONFIG_ACPI_APEI=y
CONFIG_ACPI_APEI_GHES=y
CONFIG_ACPI_APEI_PCIEAER=y
CONFIG_ACPI_APEI_MEMORY_FAILURE=y
CONFIG_ACPI_APEI_EINJ=m
CONFIG_ACPI_APEI_ERST_DEBUG=y
# CONFIG_DPTF_POWER is not set
CONFIG_ACPI_WATCHDOG=y
CONFIG_ACPI_EXTLOG=m
CONFIG_ACPI_ADXL=y
# CONFIG_PMIC_OPREGION is not set
# CONFIG_ACPI_CONFIGFS is not set
CONFIG_X86_PM_TIMER=y
CONFIG_SFI=y

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
# CONFIG_CPU_FREQ_STAT is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
# CONFIG_CPU_FREQ_GOV_SCHEDUTIL is not set

#
# CPU frequency scaling drivers
#
CONFIG_X86_INTEL_PSTATE=y
CONFIG_X86_PCC_CPUFREQ=m
CONFIG_X86_ACPI_CPUFREQ=m
CONFIG_X86_ACPI_CPUFREQ_CPB=y
CONFIG_X86_POWERNOW_K8=m
CONFIG_X86_AMD_FREQ_SENSITIVITY=m
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
CONFIG_X86_P4_CLOCKMOD=m

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=m
# end of CPU Frequency scaling

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
# CONFIG_CPU_IDLE_GOV_LADDER is not set
CONFIG_CPU_IDLE_GOV_MENU=y
# CONFIG_CPU_IDLE_GOV_TEO is not set
# CONFIG_CPU_IDLE_GOV_HALTPOLL is not set
CONFIG_HALTPOLL_CPUIDLE=y
# end of CPU Idle

CONFIG_INTEL_IDLE=y
# end of Power management and ACPI options

#
# Bus options (PCI etc.)
#
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCI_XEN=y
CONFIG_MMCONF_FAM10H=y
# CONFIG_PCI_CNB20LE_QUIRK is not set
# CONFIG_ISA_BUS is not set
CONFIG_ISA_DMA_API=y
CONFIG_AMD_NB=y
# CONFIG_X86_SYSFB is not set
# end of Bus options (PCI etc.)

#
# Binary Emulations
#
CONFIG_IA32_EMULATION=y
# CONFIG_X86_X32 is not set
CONFIG_COMPAT_32=y
CONFIG_COMPAT=y
CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
CONFIG_SYSVIPC_COMPAT=y
# end of Binary Emulations

CONFIG_X86_DEV_DMA_OPS=y

#
# Firmware Drivers
#
CONFIG_EDD=m
# CONFIG_EDD_OFF is not set
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_DMIID=y
CONFIG_DMI_SYSFS=y
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
CONFIG_ISCSI_IBFT_FIND=y
CONFIG_ISCSI_IBFT=m
CONFIG_FW_CFG_SYSFS=y
# CONFIG_FW_CFG_SYSFS_CMDLINE is not set
# CONFIG_GOOGLE_FIRMWARE is not set

#
# EFI (Extensible Firmware Interface) Support
#
CONFIG_EFI_VARS=y
CONFIG_EFI_ESRT=y
CONFIG_EFI_VARS_PSTORE=y
CONFIG_EFI_VARS_PSTORE_DEFAULT_DISABLE=y
CONFIG_EFI_RUNTIME_MAP=y
# CONFIG_EFI_FAKE_MEMMAP is not set
CONFIG_EFI_RUNTIME_WRAPPERS=y
# CONFIG_EFI_BOOTLOADER_CONTROL is not set
# CONFIG_EFI_CAPSULE_LOADER is not set
# CONFIG_EFI_TEST is not set
CONFIG_APPLE_PROPERTIES=y
# CONFIG_RESET_ATTACK_MITIGATION is not set
# CONFIG_EFI_RCI2_TABLE is not set
# end of EFI (Extensible Firmware Interface) Support

CONFIG_UEFI_CPER=y
CONFIG_UEFI_CPER_X86=y
CONFIG_EFI_DEV_PATH_PARSER=y
CONFIG_EFI_EARLYCON=y

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

CONFIG_HAVE_KVM=y
CONFIG_HAVE_KVM_IRQCHIP=y
CONFIG_HAVE_KVM_IRQFD=y
CONFIG_HAVE_KVM_IRQ_ROUTING=y
CONFIG_HAVE_KVM_EVENTFD=y
CONFIG_KVM_MMIO=y
CONFIG_KVM_ASYNC_PF=y
CONFIG_HAVE_KVM_MSI=y
CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT=y
CONFIG_KVM_VFIO=y
CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT=y
CONFIG_KVM_COMPAT=y
CONFIG_HAVE_KVM_IRQ_BYPASS=y
CONFIG_HAVE_KVM_NO_POLL=y
CONFIG_VIRTUALIZATION=y
CONFIG_KVM=m
CONFIG_KVM_INTEL=m
CONFIG_KVM_AMD=m
CONFIG_KVM_AMD_SEV=y
CONFIG_KVM_MMU_AUDIT=y
CONFIG_VHOST_NET=m
# CONFIG_VHOST_SCSI is not set
CONFIG_VHOST_VSOCK=m
CONFIG_VHOST=m
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set

#
# General architecture-dependent options
#
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_HOTPLUG_SMT=y
CONFIG_OPROFILE=m
CONFIG_OPROFILE_EVENT_MULTIPLEX=y
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
CONFIG_KPROBES=y
CONFIG_JUMP_LABEL=y
# CONFIG_STATIC_KEYS_SELFTEST is not set
CONFIG_OPTPROBES=y
CONFIG_KPROBES_ON_FTRACE=y
CONFIG_UPROBES=y
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_KRETPROBES=y
CONFIG_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
CONFIG_HAVE_NMI=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_ARCH_HAS_SET_DIRECT_MAP=y
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_HAVE_ASM_MODVERSIONS=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_RSEQ=y
CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=y
CONFIG_HAVE_CLK=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
CONFIG_HAVE_RCU_TABLE_FREE=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=y
CONFIG_ARCH_WANT_OLD_COMPAT_IPC=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP_FILTER=y
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_CC_HAS_STACKPROTECTOR_NONE=y
CONFIG_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR_STRONG=y
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_CONTEXT_TRACKING=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_MOVE_PMD=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=y
CONFIG_HAVE_ARCH_HUGE_VMAP=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_HAVE_ARCH_SOFT_DIRTY=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=28
CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=y
CONFIG_ARCH_MMAP_RND_COMPAT_BITS=8
CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=y
CONFIG_HAVE_COPY_THREAD_TLS=y
CONFIG_HAVE_STACK_VALIDATION=y
CONFIG_HAVE_RELIABLE_STACKTRACE=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_COMPAT_OLD_SIGACTION=y
CONFIG_64BIT_TIME=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_HAVE_ARCH_VMAP_STACK=y
CONFIG_VMAP_STACK=y
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_ARCH_HAS_REFCOUNT=y
# CONFIG_REFCOUNT_FULL is not set
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
CONFIG_ARCH_USE_MEMREMAP_PROT=y
# CONFIG_LOCK_EVENT_COUNTS is not set
CONFIG_ARCH_HAS_MEM_ENCRYPT=y

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# end of GCOV-based kernel profiling

CONFIG_PLUGIN_HOSTCC="g++"
CONFIG_HAVE_GCC_PLUGINS=y
CONFIG_GCC_PLUGINS=y

#
# GCC plugins
#
# CONFIG_GCC_PLUGIN_CYC_COMPLEXITY is not set
# CONFIG_GCC_PLUGIN_LATENT_ENTROPY is not set
# CONFIG_GCC_PLUGIN_RANDSTRUCT is not set
# end of GCC plugins
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULE_SIG_FORMAT=y
CONFIG_MODULES=y
CONFIG_MODULE_FORCE_LOAD=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_MODULE_SIG=y
# CONFIG_MODULE_SIG_FORCE is not set
CONFIG_MODULE_SIG_ALL=y
# CONFIG_MODULE_SIG_SHA1 is not set
# CONFIG_MODULE_SIG_SHA224 is not set
CONFIG_MODULE_SIG_SHA256=y
# CONFIG_MODULE_SIG_SHA384 is not set
# CONFIG_MODULE_SIG_SHA512 is not set
CONFIG_MODULE_SIG_HASH="sha256"
# CONFIG_MODULE_COMPRESS is not set
# CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
# CONFIG_UNUSED_SYMBOLS is not set
# CONFIG_TRIM_UNUSED_KSYMS is not set
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLK_SCSI_REQUEST=y
CONFIG_BLK_DEV_BSG=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
CONFIG_BLK_DEV_ZONED=y
CONFIG_BLK_DEV_THROTTLING=y
# CONFIG_BLK_DEV_THROTTLING_LOW is not set
# CONFIG_BLK_CMDLINE_PARSER is not set
# CONFIG_BLK_WBT is not set
# CONFIG_BLK_CGROUP_IOLATENCY is not set
# CONFIG_BLK_CGROUP_IOCOST is not set
CONFIG_BLK_DEBUG_FS=y
CONFIG_BLK_DEBUG_FS_ZONED=y
# CONFIG_BLK_SED_OPAL is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
# CONFIG_AIX_PARTITION is not set
CONFIG_OSF_PARTITION=y
CONFIG_AMIGA_PARTITION=y
# CONFIG_ATARI_PARTITION is not set
CONFIG_MAC_PARTITION=y
CONFIG_MSDOS_PARTITION=y
CONFIG_BSD_DISKLABEL=y
CONFIG_MINIX_SUBPARTITION=y
CONFIG_SOLARIS_X86_PARTITION=y
CONFIG_UNIXWARE_DISKLABEL=y
# CONFIG_LDM_PARTITION is not set
CONFIG_SGI_PARTITION=y
# CONFIG_ULTRIX_PARTITION is not set
CONFIG_SUN_PARTITION=y
CONFIG_KARMA_PARTITION=y
CONFIG_EFI_PARTITION=y
# CONFIG_SYSV68_PARTITION is not set
# CONFIG_CMDLINE_PARTITION is not set
# end of Partition Types

CONFIG_BLOCK_COMPAT=y
CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y
CONFIG_BLK_PM=y

#
# IO Schedulers
#
CONFIG_MQ_IOSCHED_DEADLINE=y
CONFIG_MQ_IOSCHED_KYBER=y
# CONFIG_IOSCHED_BFQ is not set
# end of IO Schedulers

CONFIG_PREEMPT_NOTIFIERS=y
CONFIG_PADATA=y
CONFIG_ASN1=y
CONFIG_INLINE_SPIN_UNLOCK_IRQ=y
CONFIG_INLINE_READ_UNLOCK=y
CONFIG_INLINE_READ_UNLOCK_IRQ=y
CONFIG_INLINE_WRITE_UNLOCK=y
CONFIG_INLINE_WRITE_UNLOCK_IRQ=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_MUTEX_SPIN_ON_OWNER=y
CONFIG_RWSEM_SPIN_ON_OWNER=y
CONFIG_LOCK_SPIN_ON_OWNER=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
CONFIG_FREEZER=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_COMPAT_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_BINFMT_MISC=m
CONFIG_COREDUMP=y
# end of Executable file formats

#
# Memory Management options
#
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_SPARSEMEM_MANUAL=y
CONFIG_SPARSEMEM=y
CONFIG_NEED_MULTIPLE_NODES=y
CONFIG_HAVE_MEMORY_PRESENT=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_HAVE_MEMBLOCK_NODE_MAP=y
CONFIG_HAVE_FAST_GUP=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_HAVE_BOOTMEM_INFO_NODE=y
CONFIG_MEMORY_HOTPLUG=y
CONFIG_MEMORY_HOTPLUG_SPARSE=y
# CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE is not set
CONFIG_MEMORY_HOTREMOVE=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_MEMORY_BALLOON=y
CONFIG_BALLOON_COMPACTION=y
CONFIG_COMPACTION=y
CONFIG_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_BOUNCE=y
CONFIG_VIRT_TO_BUS=y
CONFIG_MMU_NOTIFIER=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
CONFIG_MEMORY_FAILURE=y
CONFIG_HWPOISON_INJECT=m
CONFIG_TRANSPARENT_HUGEPAGE=y
CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
# CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
CONFIG_ARCH_WANTS_THP_SWAP=y
CONFIG_THP_SWAP=y
CONFIG_TRANSPARENT_HUGE_PAGECACHE=y
CONFIG_CLEANCACHE=y
CONFIG_FRONTSWAP=y
CONFIG_CMA=y
# CONFIG_CMA_DEBUG is not set
# CONFIG_CMA_DEBUGFS is not set
CONFIG_CMA_AREAS=7
CONFIG_MEM_SOFT_DIRTY=y
CONFIG_ZSWAP=y
CONFIG_ZPOOL=y
CONFIG_ZBUD=y
# CONFIG_Z3FOLD is not set
CONFIG_ZSMALLOC=y
# CONFIG_PGTABLE_MAPPING is not set
# CONFIG_ZSMALLOC_STAT is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_DEFERRED_STRUCT_PAGE_INIT=y
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_ARCH_HAS_PTE_DEVMAP=y
CONFIG_ZONE_DEVICE=y
CONFIG_DEV_PAGEMAP_OPS=y
# CONFIG_DEVICE_PRIVATE is not set
CONFIG_FRAME_VECTOR=y
CONFIG_ARCH_USES_HIGH_VMA_FLAGS=y
CONFIG_ARCH_HAS_PKEYS=y
# CONFIG_PERCPU_STATS is not set
# CONFIG_GUP_BENCHMARK is not set
# CONFIG_READ_ONLY_THP_FOR_FS is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
# end of Memory Management options

CONFIG_NET=y
CONFIG_COMPAT_NETLINK_MESSAGES=y
CONFIG_NET_INGRESS=y
CONFIG_NET_EGRESS=y
CONFIG_SKB_EXTENSIONS=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_DIAG=m
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
CONFIG_UNIX_DIAG=m
# CONFIG_TLS is not set
CONFIG_XFRM=y
CONFIG_XFRM_ALGO=y
CONFIG_XFRM_USER=y
# CONFIG_XFRM_INTERFACE is not set
CONFIG_XFRM_SUB_POLICY=y
CONFIG_XFRM_MIGRATE=y
CONFIG_XFRM_STATISTICS=y
CONFIG_XFRM_IPCOMP=m
CONFIG_NET_KEY=m
CONFIG_NET_KEY_MIGRATE=y
# CONFIG_XDP_SOCKETS is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_FIB_TRIE_STATS=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_IP_ROUTE_CLASSID=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE_DEMUX=m
CONFIG_NET_IP_TUNNEL=m
CONFIG_NET_IPGRE=m
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_IP_MROUTE_COMMON=y
CONFIG_IP_MROUTE=y
CONFIG_IP_MROUTE_MULTIPLE_TABLES=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
CONFIG_SYN_COOKIES=y
CONFIG_NET_IPVTI=m
CONFIG_NET_UDP_TUNNEL=m
CONFIG_NET_FOU=m
CONFIG_NET_FOU_IP_TUNNELS=y
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
# CONFIG_INET_ESP_OFFLOAD is not set
CONFIG_INET_IPCOMP=m
CONFIG_INET_XFRM_TUNNEL=m
CONFIG_INET_TUNNEL=m
CONFIG_INET_DIAG=m
CONFIG_INET_TCP_DIAG=m
CONFIG_INET_UDP_DIAG=m
# CONFIG_INET_RAW_DIAG is not set
# CONFIG_INET_DIAG_DESTROY is not set
CONFIG_TCP_CONG_ADVANCED=y
CONFIG_TCP_CONG_BIC=m
CONFIG_TCP_CONG_CUBIC=y
CONFIG_TCP_CONG_WESTWOOD=m
CONFIG_TCP_CONG_HTCP=m
CONFIG_TCP_CONG_HSTCP=m
CONFIG_TCP_CONG_HYBLA=m
CONFIG_TCP_CONG_VEGAS=m
# CONFIG_TCP_CONG_NV is not set
CONFIG_TCP_CONG_SCALABLE=m
CONFIG_TCP_CONG_LP=m
CONFIG_TCP_CONG_VENO=m
CONFIG_TCP_CONG_YEAH=m
CONFIG_TCP_CONG_ILLINOIS=m
CONFIG_TCP_CONG_DCTCP=m
# CONFIG_TCP_CONG_CDG is not set
# CONFIG_TCP_CONG_BBR is not set
CONFIG_DEFAULT_CUBIC=y
# CONFIG_DEFAULT_RENO is not set
CONFIG_DEFAULT_TCP_CONG="cubic"
CONFIG_TCP_MD5SIG=y
CONFIG_IPV6=y
CONFIG_IPV6_ROUTER_PREF=y
CONFIG_IPV6_ROUTE_INFO=y
CONFIG_IPV6_OPTIMISTIC_DAD=y
CONFIG_INET6_AH=m
CONFIG_INET6_ESP=m
# CONFIG_INET6_ESP_OFFLOAD is not set
CONFIG_INET6_IPCOMP=m
CONFIG_IPV6_MIP6=m
# CONFIG_IPV6_ILA is not set
CONFIG_INET6_XFRM_TUNNEL=m
CONFIG_INET6_TUNNEL=m
CONFIG_IPV6_VTI=m
CONFIG_IPV6_SIT=m
CONFIG_IPV6_SIT_6RD=y
CONFIG_IPV6_NDISC_NODETYPE=y
CONFIG_IPV6_TUNNEL=m
CONFIG_IPV6_GRE=m
CONFIG_IPV6_FOU=m
CONFIG_IPV6_FOU_TUNNEL=m
CONFIG_IPV6_MULTIPLE_TABLES=y
# CONFIG_IPV6_SUBTREES is not set
CONFIG_IPV6_MROUTE=y
CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=y
CONFIG_IPV6_PIMSM_V2=y
CONFIG_IPV6_SEG6_LWTUNNEL=y
# CONFIG_IPV6_SEG6_HMAC is not set
CONFIG_IPV6_SEG6_BPF=y
CONFIG_NETLABEL=y
CONFIG_NETWORK_SECMARK=y
CONFIG_NET_PTP_CLASSIFY=y
CONFIG_NETWORK_PHY_TIMESTAMPING=y
CONFIG_NETFILTER=y
CONFIG_NETFILTER_ADVANCED=y
CONFIG_BRIDGE_NETFILTER=m

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_INGRESS=y
CONFIG_NETFILTER_NETLINK=m
CONFIG_NETFILTER_FAMILY_BRIDGE=y
CONFIG_NETFILTER_FAMILY_ARP=y
CONFIG_NETFILTER_NETLINK_ACCT=m
CONFIG_NETFILTER_NETLINK_QUEUE=m
CONFIG_NETFILTER_NETLINK_LOG=m
CONFIG_NETFILTER_NETLINK_OSF=m
CONFIG_NF_CONNTRACK=m
CONFIG_NF_LOG_COMMON=m
# CONFIG_NF_LOG_NETDEV is not set
CONFIG_NETFILTER_CONNCOUNT=m
CONFIG_NF_CONNTRACK_MARK=y
CONFIG_NF_CONNTRACK_SECMARK=y
CONFIG_NF_CONNTRACK_ZONES=y
CONFIG_NF_CONNTRACK_PROCFS=y
CONFIG_NF_CONNTRACK_EVENTS=y
CONFIG_NF_CONNTRACK_TIMEOUT=y
CONFIG_NF_CONNTRACK_TIMESTAMP=y
CONFIG_NF_CONNTRACK_LABELS=y
CONFIG_NF_CT_PROTO_DCCP=y
CONFIG_NF_CT_PROTO_GRE=y
CONFIG_NF_CT_PROTO_SCTP=y
CONFIG_NF_CT_PROTO_UDPLITE=y
CONFIG_NF_CONNTRACK_AMANDA=m
CONFIG_NF_CONNTRACK_FTP=m
CONFIG_NF_CONNTRACK_H323=m
CONFIG_NF_CONNTRACK_IRC=m
CONFIG_NF_CONNTRACK_BROADCAST=m
CONFIG_NF_CONNTRACK_NETBIOS_NS=m
CONFIG_NF_CONNTRACK_SNMP=m
CONFIG_NF_CONNTRACK_PPTP=m
CONFIG_NF_CONNTRACK_SANE=m
CONFIG_NF_CONNTRACK_SIP=m
CONFIG_NF_CONNTRACK_TFTP=m
CONFIG_NF_CT_NETLINK=m
CONFIG_NF_CT_NETLINK_TIMEOUT=m
# CONFIG_NETFILTER_NETLINK_GLUE_CT is not set
CONFIG_NF_NAT=m
CONFIG_NF_NAT_AMANDA=m
CONFIG_NF_NAT_FTP=m
CONFIG_NF_NAT_IRC=m
CONFIG_NF_NAT_SIP=m
CONFIG_NF_NAT_TFTP=m
CONFIG_NF_NAT_REDIRECT=y
CONFIG_NF_NAT_MASQUERADE=y
CONFIG_NETFILTER_SYNPROXY=m
CONFIG_NF_TABLES=m
# CONFIG_NF_TABLES_SET is not set
# CONFIG_NF_TABLES_INET is not set
# CONFIG_NF_TABLES_NETDEV is not set
# CONFIG_NFT_NUMGEN is not set
CONFIG_NFT_CT=m
CONFIG_NFT_COUNTER=m
# CONFIG_NFT_CONNLIMIT is not set
CONFIG_NFT_LOG=m
CONFIG_NFT_LIMIT=m
CONFIG_NFT_MASQ=m
CONFIG_NFT_REDIR=m
# CONFIG_NFT_TUNNEL is not set
# CONFIG_NFT_OBJREF is not set
CONFIG_NFT_QUEUE=m
# CONFIG_NFT_QUOTA is not set
CONFIG_NFT_REJECT=m
CONFIG_NFT_COMPAT=m
CONFIG_NFT_HASH=m
# CONFIG_NFT_XFRM is not set
# CONFIG_NFT_SOCKET is not set
# CONFIG_NFT_OSF is not set
# CONFIG_NFT_TPROXY is not set
# CONFIG_NFT_SYNPROXY is not set
# CONFIG_NF_FLOW_TABLE is not set
CONFIG_NETFILTER_XTABLES=y

#
# Xtables combined modules
#
CONFIG_NETFILTER_XT_MARK=m
CONFIG_NETFILTER_XT_CONNMARK=m
CONFIG_NETFILTER_XT_SET=m

#
# Xtables targets
#
CONFIG_NETFILTER_XT_TARGET_AUDIT=m
CONFIG_NETFILTER_XT_TARGET_CHECKSUM=m
CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
CONFIG_NETFILTER_XT_TARGET_CONNMARK=m
CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=m
CONFIG_NETFILTER_XT_TARGET_CT=m
CONFIG_NETFILTER_XT_TARGET_DSCP=m
CONFIG_NETFILTER_XT_TARGET_HL=m
CONFIG_NETFILTER_XT_TARGET_HMARK=m
CONFIG_NETFILTER_XT_TARGET_IDLETIMER=m
CONFIG_NETFILTER_XT_TARGET_LED=m
CONFIG_NETFILTER_XT_TARGET_LOG=m
CONFIG_NETFILTER_XT_TARGET_MARK=m
CONFIG_NETFILTER_XT_NAT=m
CONFIG_NETFILTER_XT_TARGET_NETMAP=m
CONFIG_NETFILTER_XT_TARGET_NFLOG=m
CONFIG_NETFILTER_XT_TARGET_NFQUEUE=m
CONFIG_NETFILTER_XT_TARGET_NOTRACK=m
CONFIG_NETFILTER_XT_TARGET_RATEEST=m
CONFIG_NETFILTER_XT_TARGET_REDIRECT=m
CONFIG_NETFILTER_XT_TARGET_MASQUERADE=m
CONFIG_NETFILTER_XT_TARGET_TEE=m
CONFIG_NETFILTER_XT_TARGET_TPROXY=m
CONFIG_NETFILTER_XT_TARGET_TRACE=m
CONFIG_NETFILTER_XT_TARGET_SECMARK=m
CONFIG_NETFILTER_XT_TARGET_TCPMSS=m
CONFIG_NETFILTER_XT_TARGET_TCPOPTSTRIP=m

#
# Xtables matches
#
CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=m
CONFIG_NETFILTER_XT_MATCH_BPF=m
CONFIG_NETFILTER_XT_MATCH_CGROUP=m
CONFIG_NETFILTER_XT_MATCH_CLUSTER=m
CONFIG_NETFILTER_XT_MATCH_COMMENT=m
CONFIG_NETFILTER_XT_MATCH_CONNBYTES=m
CONFIG_NETFILTER_XT_MATCH_CONNLABEL=m
CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=m
CONFIG_NETFILTER_XT_MATCH_CONNMARK=m
CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
CONFIG_NETFILTER_XT_MATCH_CPU=m
CONFIG_NETFILTER_XT_MATCH_DCCP=m
CONFIG_NETFILTER_XT_MATCH_DEVGROUP=m
CONFIG_NETFILTER_XT_MATCH_DSCP=m
CONFIG_NETFILTER_XT_MATCH_ECN=m
CONFIG_NETFILTER_XT_MATCH_ESP=m
CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=m
CONFIG_NETFILTER_XT_MATCH_HELPER=m
CONFIG_NETFILTER_XT_MATCH_HL=m
# CONFIG_NETFILTER_XT_MATCH_IPCOMP is not set
CONFIG_NETFILTER_XT_MATCH_IPRANGE=m
CONFIG_NETFILTER_XT_MATCH_IPVS=m
CONFIG_NETFILTER_XT_MATCH_L2TP=m
CONFIG_NETFILTER_XT_MATCH_LENGTH=m
CONFIG_NETFILTER_XT_MATCH_LIMIT=m
CONFIG_NETFILTER_XT_MATCH_MAC=m
CONFIG_NETFILTER_XT_MATCH_MARK=m
CONFIG_NETFILTER_XT_MATCH_MULTIPORT=m
CONFIG_NETFILTER_XT_MATCH_NFACCT=m
CONFIG_NETFILTER_XT_MATCH_OSF=m
CONFIG_NETFILTER_XT_MATCH_OWNER=m
CONFIG_NETFILTER_XT_MATCH_POLICY=m
CONFIG_NETFILTER_XT_MATCH_PHYSDEV=m
CONFIG_NETFILTER_XT_MATCH_PKTTYPE=m
CONFIG_NETFILTER_XT_MATCH_QUOTA=m
CONFIG_NETFILTER_XT_MATCH_RATEEST=m
CONFIG_NETFILTER_XT_MATCH_REALM=m
CONFIG_NETFILTER_XT_MATCH_RECENT=m
CONFIG_NETFILTER_XT_MATCH_SCTP=m
CONFIG_NETFILTER_XT_MATCH_SOCKET=m
CONFIG_NETFILTER_XT_MATCH_STATE=m
CONFIG_NETFILTER_XT_MATCH_STATISTIC=m
CONFIG_NETFILTER_XT_MATCH_STRING=m
CONFIG_NETFILTER_XT_MATCH_TCPMSS=m
CONFIG_NETFILTER_XT_MATCH_TIME=m
CONFIG_NETFILTER_XT_MATCH_U32=m
# end of Core Netfilter Configuration

CONFIG_IP_SET=m
CONFIG_IP_SET_MAX=256
CONFIG_IP_SET_BITMAP_IP=m
CONFIG_IP_SET_BITMAP_IPMAC=m
CONFIG_IP_SET_BITMAP_PORT=m
CONFIG_IP_SET_HASH_IP=m
CONFIG_IP_SET_HASH_IPMARK=m
CONFIG_IP_SET_HASH_IPPORT=m
CONFIG_IP_SET_HASH_IPPORTIP=m
CONFIG_IP_SET_HASH_IPPORTNET=m
CONFIG_IP_SET_HASH_IPMAC=m
CONFIG_IP_SET_HASH_MAC=m
CONFIG_IP_SET_HASH_NETPORTNET=m
CONFIG_IP_SET_HASH_NET=m
CONFIG_IP_SET_HASH_NETNET=m
CONFIG_IP_SET_HASH_NETPORT=m
CONFIG_IP_SET_HASH_NETIFACE=m
CONFIG_IP_SET_LIST_SET=m
CONFIG_IP_VS=m
CONFIG_IP_VS_IPV6=y
# CONFIG_IP_VS_DEBUG is not set
CONFIG_IP_VS_TAB_BITS=12

#
# IPVS transport protocol load balancing support
#
CONFIG_IP_VS_PROTO_TCP=y
CONFIG_IP_VS_PROTO_UDP=y
CONFIG_IP_VS_PROTO_AH_ESP=y
CONFIG_IP_VS_PROTO_ESP=y
CONFIG_IP_VS_PROTO_AH=y
CONFIG_IP_VS_PROTO_SCTP=y

#
# IPVS scheduler
#
CONFIG_IP_VS_RR=m
CONFIG_IP_VS_WRR=m
CONFIG_IP_VS_LC=m
CONFIG_IP_VS_WLC=m
# CONFIG_IP_VS_FO is not set
# CONFIG_IP_VS_OVF is not set
CONFIG_IP_VS_LBLC=m
CONFIG_IP_VS_LBLCR=m
CONFIG_IP_VS_DH=m
CONFIG_IP_VS_SH=m
# CONFIG_IP_VS_MH is not set
CONFIG_IP_VS_SED=m
CONFIG_IP_VS_NQ=m

#
# IPVS SH scheduler
#
CONFIG_IP_VS_SH_TAB_BITS=8

#
# IPVS MH scheduler
#
CONFIG_IP_VS_MH_TAB_INDEX=12

#
# IPVS application helper
#
CONFIG_IP_VS_FTP=m
CONFIG_IP_VS_NFCT=y
CONFIG_IP_VS_PE_SIP=m

#
# IP: Netfilter Configuration
#
CONFIG_NF_DEFRAG_IPV4=m
CONFIG_NF_SOCKET_IPV4=m
CONFIG_NF_TPROXY_IPV4=m
# CONFIG_NF_TABLES_IPV4 is not set
# CONFIG_NF_TABLES_ARP is not set
CONFIG_NF_DUP_IPV4=m
# CONFIG_NF_LOG_ARP is not set
CONFIG_NF_LOG_IPV4=m
CONFIG_NF_REJECT_IPV4=m
CONFIG_NF_NAT_SNMP_BASIC=m
CONFIG_NF_NAT_PPTP=m
CONFIG_NF_NAT_H323=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_AH=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_RPFILTER=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_SYNPROXY=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_NETMAP=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_CLUSTERIP=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_TTL=m
CONFIG_IP_NF_RAW=m
CONFIG_IP_NF_SECURITY=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_ARP_MANGLE=m
# end of IP: Netfilter Configuration

#
# IPv6: Netfilter Configuration
#
CONFIG_NF_SOCKET_IPV6=m
CONFIG_NF_TPROXY_IPV6=m
# CONFIG_NF_TABLES_IPV6 is not set
CONFIG_NF_DUP_IPV6=m
CONFIG_NF_REJECT_IPV6=m
CONFIG_NF_LOG_IPV6=m
CONFIG_IP6_NF_IPTABLES=m
CONFIG_IP6_NF_MATCH_AH=m
CONFIG_IP6_NF_MATCH_EUI64=m
CONFIG_IP6_NF_MATCH_FRAG=m
CONFIG_IP6_NF_MATCH_OPTS=m
CONFIG_IP6_NF_MATCH_HL=m
CONFIG_IP6_NF_MATCH_IPV6HEADER=m
CONFIG_IP6_NF_MATCH_MH=m
CONFIG_IP6_NF_MATCH_RPFILTER=m
CONFIG_IP6_NF_MATCH_RT=m
# CONFIG_IP6_NF_MATCH_SRH is not set
CONFIG_IP6_NF_TARGET_HL=m
CONFIG_IP6_NF_FILTER=m
CONFIG_IP6_NF_TARGET_REJECT=m
CONFIG_IP6_NF_TARGET_SYNPROXY=m
CONFIG_IP6_NF_MANGLE=m
CONFIG_IP6_NF_RAW=m
CONFIG_IP6_NF_SECURITY=m
CONFIG_IP6_NF_NAT=m
CONFIG_IP6_NF_TARGET_MASQUERADE=m
CONFIG_IP6_NF_TARGET_NPT=m
# end of IPv6: Netfilter Configuration

CONFIG_NF_DEFRAG_IPV6=m
# CONFIG_NF_TABLES_BRIDGE is not set
# CONFIG_NF_CONNTRACK_BRIDGE is not set
CONFIG_BRIDGE_NF_EBTABLES=m
CONFIG_BRIDGE_EBT_BROUTE=m
CONFIG_BRIDGE_EBT_T_FILTER=m
CONFIG_BRIDGE_EBT_T_NAT=m
CONFIG_BRIDGE_EBT_802_3=m
CONFIG_BRIDGE_EBT_AMONG=m
CONFIG_BRIDGE_EBT_ARP=m
CONFIG_BRIDGE_EBT_IP=m
CONFIG_BRIDGE_EBT_IP6=m
CONFIG_BRIDGE_EBT_LIMIT=m
CONFIG_BRIDGE_EBT_MARK=m
CONFIG_BRIDGE_EBT_PKTTYPE=m
CONFIG_BRIDGE_EBT_STP=m
CONFIG_BRIDGE_EBT_VLAN=m
CONFIG_BRIDGE_EBT_ARPREPLY=m
CONFIG_BRIDGE_EBT_DNAT=m
CONFIG_BRIDGE_EBT_MARK_T=m
CONFIG_BRIDGE_EBT_REDIRECT=m
CONFIG_BRIDGE_EBT_SNAT=m
CONFIG_BRIDGE_EBT_LOG=m
CONFIG_BRIDGE_EBT_NFLOG=m
# CONFIG_BPFILTER is not set
CONFIG_IP_DCCP=m
CONFIG_INET_DCCP_DIAG=m

#
# DCCP CCIDs Configuration
#
# CONFIG_IP_DCCP_CCID2_DEBUG is not set
CONFIG_IP_DCCP_CCID3=y
# CONFIG_IP_DCCP_CCID3_DEBUG is not set
CONFIG_IP_DCCP_TFRC_LIB=y
# end of DCCP CCIDs Configuration

#
# DCCP Kernel Hacking
#
# CONFIG_IP_DCCP_DEBUG is not set
# end of DCCP Kernel Hacking

CONFIG_IP_SCTP=m
# CONFIG_SCTP_DBG_OBJCNT is not set
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5 is not set
CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1=y
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE is not set
CONFIG_SCTP_COOKIE_HMAC_MD5=y
CONFIG_SCTP_COOKIE_HMAC_SHA1=y
CONFIG_INET_SCTP_DIAG=m
# CONFIG_RDS is not set
# CONFIG_TIPC is not set
CONFIG_ATM=m
CONFIG_ATM_CLIP=m
# CONFIG_ATM_CLIP_NO_ICMP is not set
CONFIG_ATM_LANE=m
# CONFIG_ATM_MPOA is not set
CONFIG_ATM_BR2684=m
# CONFIG_ATM_BR2684_IPFILTER is not set
CONFIG_L2TP=m
CONFIG_L2TP_DEBUGFS=m
CONFIG_L2TP_V3=y
CONFIG_L2TP_IP=m
CONFIG_L2TP_ETH=m
CONFIG_STP=m
CONFIG_GARP=m
CONFIG_MRP=m
CONFIG_BRIDGE=m
CONFIG_BRIDGE_IGMP_SNOOPING=y
CONFIG_BRIDGE_VLAN_FILTERING=y
CONFIG_HAVE_NET_DSA=y
# CONFIG_NET_DSA is not set
CONFIG_VLAN_8021Q=m
CONFIG_VLAN_8021Q_GVRP=y
CONFIG_VLAN_8021Q_MVRP=y
# CONFIG_DECNET is not set
CONFIG_LLC=m
# CONFIG_LLC2 is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
CONFIG_6LOWPAN=m
# CONFIG_6LOWPAN_DEBUGFS is not set
CONFIG_6LOWPAN_NHC=m
CONFIG_6LOWPAN_NHC_DEST=m
CONFIG_6LOWPAN_NHC_FRAGMENT=m
CONFIG_6LOWPAN_NHC_HOP=m
CONFIG_6LOWPAN_NHC_IPV6=m
CONFIG_6LOWPAN_NHC_MOBILITY=m
CONFIG_6LOWPAN_NHC_ROUTING=m
CONFIG_6LOWPAN_NHC_UDP=m
# CONFIG_6LOWPAN_GHC_EXT_HDR_HOP is not set
# CONFIG_6LOWPAN_GHC_UDP is not set
# CONFIG_6LOWPAN_GHC_ICMPV6 is not set
# CONFIG_6LOWPAN_GHC_EXT_HDR_DEST is not set
# CONFIG_6LOWPAN_GHC_EXT_HDR_FRAG is not set
# CONFIG_6LOWPAN_GHC_EXT_HDR_ROUTE is not set
CONFIG_IEEE802154=m
# CONFIG_IEEE802154_NL802154_EXPERIMENTAL is not set
CONFIG_IEEE802154_SOCKET=m
CONFIG_IEEE802154_6LOWPAN=m
CONFIG_MAC802154=m
CONFIG_NET_SCHED=y

#
# Queueing/Scheduling
#
CONFIG_NET_SCH_CBQ=m
CONFIG_NET_SCH_HTB=m
CONFIG_NET_SCH_HFSC=m
CONFIG_NET_SCH_ATM=m
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_MULTIQ=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFB=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
# CONFIG_NET_SCH_CBS is not set
# CONFIG_NET_SCH_ETF is not set
# CONFIG_NET_SCH_TAPRIO is not set
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_DSMARK=m
CONFIG_NET_SCH_NETEM=m
CONFIG_NET_SCH_DRR=m
CONFIG_NET_SCH_MQPRIO=m
# CONFIG_NET_SCH_SKBPRIO is not set
CONFIG_NET_SCH_CHOKE=m
CONFIG_NET_SCH_QFQ=m
CONFIG_NET_SCH_CODEL=m
CONFIG_NET_SCH_FQ_CODEL=m
# CONFIG_NET_SCH_CAKE is not set
CONFIG_NET_SCH_FQ=m
# CONFIG_NET_SCH_HHF is not set
# CONFIG_NET_SCH_PIE is not set
CONFIG_NET_SCH_INGRESS=m
CONFIG_NET_SCH_PLUG=m
# CONFIG_NET_SCH_DEFAULT is not set

#
# Classification
#
CONFIG_NET_CLS=y
CONFIG_NET_CLS_BASIC=m
CONFIG_NET_CLS_TCINDEX=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
CONFIG_CLS_U32_PERF=y
CONFIG_CLS_U32_MARK=y
CONFIG_NET_CLS_RSVP=m
CONFIG_NET_CLS_RSVP6=m
CONFIG_NET_CLS_FLOW=m
CONFIG_NET_CLS_CGROUP=y
CONFIG_NET_CLS_BPF=m
CONFIG_NET_CLS_FLOWER=m
CONFIG_NET_CLS_MATCHALL=m
CONFIG_NET_EMATCH=y
CONFIG_NET_EMATCH_STACK=32
CONFIG_NET_EMATCH_CMP=m
CONFIG_NET_EMATCH_NBYTE=m
CONFIG_NET_EMATCH_U32=m
CONFIG_NET_EMATCH_META=m
CONFIG_NET_EMATCH_TEXT=m
# CONFIG_NET_EMATCH_CANID is not set
CONFIG_NET_EMATCH_IPSET=m
# CONFIG_NET_EMATCH_IPT is not set
CONFIG_NET_CLS_ACT=y
CONFIG_NET_ACT_POLICE=m
CONFIG_NET_ACT_GACT=m
CONFIG_GACT_PROB=y
CONFIG_NET_ACT_MIRRED=m
CONFIG_NET_ACT_SAMPLE=m
CONFIG_NET_ACT_IPT=m
CONFIG_NET_ACT_NAT=m
CONFIG_NET_ACT_PEDIT=m
CONFIG_NET_ACT_SIMP=m
CONFIG_NET_ACT_SKBEDIT=m
CONFIG_NET_ACT_CSUM=m
# CONFIG_NET_ACT_MPLS is not set
CONFIG_NET_ACT_VLAN=m
# CONFIG_NET_ACT_BPF is not set
CONFIG_NET_ACT_CONNMARK=m
# CONFIG_NET_ACT_CTINFO is not set
CONFIG_NET_ACT_SKBMOD=m
# CONFIG_NET_ACT_IFE is not set
CONFIG_NET_ACT_TUNNEL_KEY=m
# CONFIG_NET_ACT_CT is not set
# CONFIG_NET_TC_SKB_EXT is not set
CONFIG_NET_SCH_FIFO=y
CONFIG_DCB=y
CONFIG_DNS_RESOLVER=m
# CONFIG_BATMAN_ADV is not set
CONFIG_OPENVSWITCH=m
CONFIG_OPENVSWITCH_GRE=m
CONFIG_OPENVSWITCH_VXLAN=m
CONFIG_OPENVSWITCH_GENEVE=m
CONFIG_VSOCKETS=m
CONFIG_VSOCKETS_DIAG=m
CONFIG_VMWARE_VMCI_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS_COMMON=m
CONFIG_HYPERV_VSOCKETS=m
CONFIG_NETLINK_DIAG=m
CONFIG_MPLS=y
CONFIG_NET_MPLS_GSO=y
CONFIG_MPLS_ROUTING=m
CONFIG_MPLS_IPTUNNEL=m
CONFIG_NET_NSH=m
# CONFIG_HSR is not set
CONFIG_NET_SWITCHDEV=y
CONFIG_NET_L3_MASTER_DEV=y
# CONFIG_NET_NCSI is not set
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_XPS=y
# CONFIG_CGROUP_NET_PRIO is not set
CONFIG_CGROUP_NET_CLASSID=y
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_BPF_JIT=y
CONFIG_BPF_STREAM_PARSER=y
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
CONFIG_NET_PKTGEN=m
CONFIG_NET_DROP_MONITOR=y
# end of Network testing
# end of Networking options

# CONFIG_HAMRADIO is not set
CONFIG_CAN=m
CONFIG_CAN_RAW=m
CONFIG_CAN_BCM=m
CONFIG_CAN_GW=m
# CONFIG_CAN_J1939 is not set

#
# CAN Device Drivers
#
CONFIG_CAN_VCAN=m
# CONFIG_CAN_VXCAN is not set
CONFIG_CAN_SLCAN=m
CONFIG_CAN_DEV=m
CONFIG_CAN_CALC_BITTIMING=y
# CONFIG_CAN_KVASER_PCIEFD is not set
CONFIG_CAN_C_CAN=m
CONFIG_CAN_C_CAN_PLATFORM=m
CONFIG_CAN_C_CAN_PCI=m
CONFIG_CAN_CC770=m
# CONFIG_CAN_CC770_ISA is not set
CONFIG_CAN_CC770_PLATFORM=m
# CONFIG_CAN_IFI_CANFD is not set
# CONFIG_CAN_M_CAN is not set
# CONFIG_CAN_PEAK_PCIEFD is not set
CONFIG_CAN_SJA1000=m
CONFIG_CAN_EMS_PCI=m
# CONFIG_CAN_F81601 is not set
CONFIG_CAN_KVASER_PCI=m
CONFIG_CAN_PEAK_PCI=m
CONFIG_CAN_PEAK_PCIEC=y
CONFIG_CAN_PLX_PCI=m
# CONFIG_CAN_SJA1000_ISA is not set
CONFIG_CAN_SJA1000_PLATFORM=m
CONFIG_CAN_SOFTING=m

#
# CAN SPI interfaces
#
# CONFIG_CAN_HI311X is not set
# CONFIG_CAN_MCP251X is not set
# end of CAN SPI interfaces

#
# CAN USB interfaces
#
CONFIG_CAN_8DEV_USB=m
CONFIG_CAN_EMS_USB=m
CONFIG_CAN_ESD_USB2=m
# CONFIG_CAN_GS_USB is not set
CONFIG_CAN_KVASER_USB=m
# CONFIG_CAN_MCBA_USB is not set
CONFIG_CAN_PEAK_USB=m
# CONFIG_CAN_UCAN is not set
# end of CAN USB interfaces

# CONFIG_CAN_DEBUG_DEVICES is not set
# end of CAN Device Drivers

CONFIG_BT=m
CONFIG_BT_BREDR=y
CONFIG_BT_RFCOMM=m
CONFIG_BT_RFCOMM_TTY=y
CONFIG_BT_BNEP=m
CONFIG_BT_BNEP_MC_FILTER=y
CONFIG_BT_BNEP_PROTO_FILTER=y
CONFIG_BT_CMTP=m
CONFIG_BT_HIDP=m
CONFIG_BT_HS=y
CONFIG_BT_LE=y
# CONFIG_BT_6LOWPAN is not set
# CONFIG_BT_LEDS is not set
# CONFIG_BT_SELFTEST is not set
CONFIG_BT_DEBUGFS=y

#
# Bluetooth device drivers
#
CONFIG_BT_INTEL=m
CONFIG_BT_BCM=m
CONFIG_BT_RTL=m
CONFIG_BT_HCIBTUSB=m
# CONFIG_BT_HCIBTUSB_AUTOSUSPEND is not set
CONFIG_BT_HCIBTUSB_BCM=y
# CONFIG_BT_HCIBTUSB_MTK is not set
CONFIG_BT_HCIBTUSB_RTL=y
CONFIG_BT_HCIBTSDIO=m
CONFIG_BT_HCIUART=m
CONFIG_BT_HCIUART_H4=y
CONFIG_BT_HCIUART_BCSP=y
CONFIG_BT_HCIUART_ATH3K=y
# CONFIG_BT_HCIUART_INTEL is not set
# CONFIG_BT_HCIUART_AG6XX is not set
CONFIG_BT_HCIBCM203X=m
CONFIG_BT_HCIBPA10X=m
CONFIG_BT_HCIBFUSB=m
CONFIG_BT_HCIVHCI=m
CONFIG_BT_MRVL=m
CONFIG_BT_MRVL_SDIO=m
CONFIG_BT_ATH3K=m
# CONFIG_BT_MTKSDIO is not set
# end of Bluetooth device drivers

# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
CONFIG_STREAM_PARSER=y
CONFIG_FIB_RULES=y
CONFIG_WIRELESS=y
CONFIG_WIRELESS_EXT=y
CONFIG_WEXT_CORE=y
CONFIG_WEXT_PROC=y
CONFIG_WEXT_PRIV=y
CONFIG_CFG80211=m
# CONFIG_NL80211_TESTMODE is not set
# CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
# CONFIG_CFG80211_CERTIFICATION_ONUS is not set
CONFIG_CFG80211_REQUIRE_SIGNED_REGDB=y
CONFIG_CFG80211_USE_KERNEL_REGDB_KEYS=y
CONFIG_CFG80211_DEFAULT_PS=y
# CONFIG_CFG80211_DEBUGFS is not set
CONFIG_CFG80211_CRDA_SUPPORT=y
CONFIG_CFG80211_WEXT=y
CONFIG_LIB80211=m
# CONFIG_LIB80211_DEBUG is not set
CONFIG_MAC80211=m
CONFIG_MAC80211_HAS_RC=y
CONFIG_MAC80211_RC_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT="minstrel_ht"
CONFIG_MAC80211_MESH=y
CONFIG_MAC80211_LEDS=y
CONFIG_MAC80211_DEBUGFS=y
# CONFIG_MAC80211_MESSAGE_TRACING is not set
# CONFIG_MAC80211_DEBUG_MENU is not set
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
# CONFIG_WIMAX is not set
CONFIG_RFKILL=m
CONFIG_RFKILL_LEDS=y
CONFIG_RFKILL_INPUT=y
# CONFIG_RFKILL_GPIO is not set
CONFIG_NET_9P=y
CONFIG_NET_9P_VIRTIO=y
# CONFIG_NET_9P_XEN is not set
# CONFIG_NET_9P_DEBUG is not set
# CONFIG_CAIF is not set
CONFIG_CEPH_LIB=m
# CONFIG_CEPH_LIB_PRETTYDEBUG is not set
CONFIG_CEPH_LIB_USE_DNS_RESOLVER=y
# CONFIG_NFC is not set
CONFIG_PSAMPLE=m
# CONFIG_NET_IFE is not set
CONFIG_LWTUNNEL=y
CONFIG_LWTUNNEL_BPF=y
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_NET_SOCK_MSG=y
CONFIG_NET_DEVLINK=y
CONFIG_PAGE_POOL=y
CONFIG_FAILOVER=m
CONFIG_HAVE_EBPF_JIT=y

#
# Device Drivers
#
CONFIG_HAVE_EISA=y
# CONFIG_EISA is not set
CONFIG_HAVE_PCI=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
CONFIG_PCIEPORTBUS=y
CONFIG_HOTPLUG_PCI_PCIE=y
CONFIG_PCIEAER=y
CONFIG_PCIEAER_INJECT=m
CONFIG_PCIE_ECRC=y
CONFIG_PCIEASPM=y
# CONFIG_PCIEASPM_DEBUG is not set
CONFIG_PCIEASPM_DEFAULT=y
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
# CONFIG_PCIEASPM_PERFORMANCE is not set
CONFIG_PCIE_PME=y
# CONFIG_PCIE_DPC is not set
# CONFIG_PCIE_PTM is not set
# CONFIG_PCIE_BW is not set
CONFIG_PCI_MSI=y
CONFIG_PCI_MSI_IRQ_DOMAIN=y
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
CONFIG_PCI_STUB=y
# CONFIG_PCI_PF_STUB is not set
# CONFIG_XEN_PCIDEV_FRONTEND is not set
CONFIG_PCI_ATS=y
CONFIG_PCI_LOCKLESS_CONFIG=y
CONFIG_PCI_IOV=y
CONFIG_PCI_PRI=y
CONFIG_PCI_PASID=y
# CONFIG_PCI_P2PDMA is not set
CONFIG_PCI_LABEL=y
CONFIG_PCI_HYPERV=m
CONFIG_HOTPLUG_PCI=y
CONFIG_HOTPLUG_PCI_ACPI=y
CONFIG_HOTPLUG_PCI_ACPI_IBM=m
# CONFIG_HOTPLUG_PCI_CPCI is not set
CONFIG_HOTPLUG_PCI_SHPC=y

#
# PCI controller drivers
#

#
# Cadence PCIe controllers support
#
# end of Cadence PCIe controllers support

CONFIG_VMD=y
CONFIG_PCI_HYPERV_INTERFACE=m

#
# DesignWare PCI Core Support
#
# CONFIG_PCIE_DW_PLAT_HOST is not set
# CONFIG_PCI_MESON is not set
# end of DesignWare PCI Core Support
# end of PCI controller drivers

#
# PCI Endpoint
#
# CONFIG_PCI_ENDPOINT is not set
# end of PCI Endpoint

#
# PCI switch controller drivers
#
# CONFIG_PCI_SW_SWITCHTEC is not set
# end of PCI switch controller drivers

CONFIG_PCCARD=y
# CONFIG_PCMCIA is not set
CONFIG_CARDBUS=y

#
# PC-card bridges
#
CONFIG_YENTA=m
CONFIG_YENTA_O2=y
CONFIG_YENTA_RICOH=y
CONFIG_YENTA_TI=y
CONFIG_YENTA_ENE_TUNE=y
CONFIG_YENTA_TOSHIBA=y
# CONFIG_RAPIDIO is not set

#
# Generic Driver Options
#
CONFIG_UEVENT_HELPER=y
CONFIG_UEVENT_HELPER_PATH=""
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_FW_LOADER_PAGED_BUF=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
# CONFIG_FW_LOADER_COMPRESS is not set
# end of Firmware loader

CONFIG_WANT_DEV_COREDUMP=y
CONFIG_ALLOW_DEV_COREDUMP=y
CONFIG_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_SYS_HYPERVISOR=y
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_SPI=y
CONFIG_REGMAP_IRQ=y
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
# end of Generic Driver Options

#
# Bus devices
#
# end of Bus devices

CONFIG_CONNECTOR=y
CONFIG_PROC_EVENTS=y
# CONFIG_GNSS is not set
CONFIG_MTD=m
# CONFIG_MTD_TESTS is not set

#
# Partition parsers
#
# CONFIG_MTD_AR7_PARTS is not set
# CONFIG_MTD_CMDLINE_PARTS is not set
# CONFIG_MTD_REDBOOT_PARTS is not set
# end of Partition parsers

#
# User Modules And Translation Layers
#
CONFIG_MTD_BLKDEVS=m
CONFIG_MTD_BLOCK=m
# CONFIG_MTD_BLOCK_RO is not set
# CONFIG_FTL is not set
# CONFIG_NFTL is not set
# CONFIG_INFTL is not set
# CONFIG_RFD_FTL is not set
# CONFIG_SSFDC is not set
# CONFIG_SM_FTL is not set
# CONFIG_MTD_OOPS is not set
# CONFIG_MTD_SWAP is not set
# CONFIG_MTD_PARTITIONED_MASTER is not set

#
# RAM/ROM/Flash chip drivers
#
# CONFIG_MTD_CFI is not set
# CONFIG_MTD_JEDECPROBE is not set
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
# CONFIG_MTD_RAM is not set
# CONFIG_MTD_ROM is not set
# CONFIG_MTD_ABSENT is not set
# end of RAM/ROM/Flash chip drivers

#
# Mapping drivers for chip access
#
# CONFIG_MTD_COMPLEX_MAPPINGS is not set
# CONFIG_MTD_INTEL_VR_NOR is not set
# CONFIG_MTD_PLATRAM is not set
# end of Mapping drivers for chip access

#
# Self-contained MTD device drivers
#
# CONFIG_MTD_PMC551 is not set
# CONFIG_MTD_DATAFLASH is not set
# CONFIG_MTD_MCHP23K256 is not set
# CONFIG_MTD_SST25L is not set
# CONFIG_MTD_SLRAM is not set
# CONFIG_MTD_PHRAM is not set
# CONFIG_MTD_MTDRAM is not set
# CONFIG_MTD_BLOCK2MTD is not set

#
# Disk-On-Chip Device Drivers
#
# CONFIG_MTD_DOCG3 is not set
# end of Self-contained MTD device drivers

# CONFIG_MTD_ONENAND is not set
# CONFIG_MTD_RAW_NAND is not set
# CONFIG_MTD_SPI_NAND is not set

#
# LPDDR & LPDDR2 PCM memory drivers
#
# CONFIG_MTD_LPDDR is not set
# end of LPDDR & LPDDR2 PCM memory drivers

# CONFIG_MTD_SPI_NOR is not set
CONFIG_MTD_UBI=m
CONFIG_MTD_UBI_WL_THRESHOLD=4096
CONFIG_MTD_UBI_BEB_LIMIT=20
# CONFIG_MTD_UBI_FASTMAP is not set
# CONFIG_MTD_UBI_GLUEBI is not set
# CONFIG_MTD_UBI_BLOCK is not set
# CONFIG_MTD_HYPERBUS is not set
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_SERIAL=m
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_AX88796 is not set
CONFIG_PARPORT_1284=y
CONFIG_PARPORT_NOT_PC=y
CONFIG_PNP=y
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
CONFIG_BLK_DEV_NULL_BLK=m
CONFIG_BLK_DEV_NULL_BLK_FAULT_INJECTION=y
CONFIG_BLK_DEV_FD=m
CONFIG_CDROM=m
# CONFIG_PARIDE is not set
CONFIG_BLK_DEV_PCIESSD_MTIP32XX=m
# CONFIG_ZRAM is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_LOOP_MIN_COUNT=0
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
# CONFIG_BLK_DEV_DRBD is not set
CONFIG_BLK_DEV_NBD=m
# CONFIG_BLK_DEV_SKD is not set
CONFIG_BLK_DEV_SX8=m
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=16384
CONFIG_CDROM_PKTCDVD=m
CONFIG_CDROM_PKTCDVD_BUFFERS=8
# CONFIG_CDROM_PKTCDVD_WCACHE is not set
CONFIG_ATA_OVER_ETH=m
CONFIG_XEN_BLKDEV_FRONTEND=m
CONFIG_VIRTIO_BLK=y
# CONFIG_VIRTIO_BLK_SCSI is not set
CONFIG_BLK_DEV_RBD=m
# CONFIG_BLK_DEV_RSXX is not set

#
# NVME Support
#
CONFIG_NVME_CORE=m
CONFIG_BLK_DEV_NVME=m
CONFIG_NVME_MULTIPATH=y
CONFIG_NVME_FABRICS=m
CONFIG_NVME_FC=m
# CONFIG_NVME_TCP is not set
CONFIG_NVME_TARGET=m
CONFIG_NVME_TARGET_LOOP=m
CONFIG_NVME_TARGET_FC=m
CONFIG_NVME_TARGET_FCLOOP=m
# CONFIG_NVME_TARGET_TCP is not set
# end of NVME Support

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=m
# CONFIG_AD525X_DPOT is not set
# CONFIG_DUMMY_IRQ is not set
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
CONFIG_TIFM_CORE=m
CONFIG_TIFM_7XX1=m
# CONFIG_ICS932S401 is not set
CONFIG_ENCLOSURE_SERVICES=m
CONFIG_SGI_XP=m
CONFIG_HP_ILO=m
CONFIG_SGI_GRU=m
# CONFIG_SGI_GRU_DEBUG is not set
CONFIG_APDS9802ALS=m
CONFIG_ISL29003=m
CONFIG_ISL29020=m
CONFIG_SENSORS_TSL2550=m
CONFIG_SENSORS_BH1770=m
CONFIG_SENSORS_APDS990X=m
# CONFIG_HMC6352 is not set
# CONFIG_DS1682 is not set
CONFIG_VMWARE_BALLOON=m
# CONFIG_LATTICE_ECP3_CONFIG is not set
# CONFIG_SRAM is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
# CONFIG_XILINX_SDFEC is not set
CONFIG_PVPANIC=y
# CONFIG_C2PORT is not set

#
# EEPROM support
#
CONFIG_EEPROM_AT24=m
# CONFIG_EEPROM_AT25 is not set
CONFIG_EEPROM_LEGACY=m
CONFIG_EEPROM_MAX6875=m
CONFIG_EEPROM_93CX6=m
# CONFIG_EEPROM_93XX46 is not set
# CONFIG_EEPROM_IDT_89HPESX is not set
# CONFIG_EEPROM_EE1004 is not set
# end of EEPROM support

CONFIG_CB710_CORE=m
# CONFIG_CB710_DEBUG is not set
CONFIG_CB710_DEBUG_ASSUMPTIONS=y

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# end of Texas Instruments shared transport line discipline

CONFIG_SENSORS_LIS3_I2C=m
CONFIG_ALTERA_STAPL=m
CONFIG_INTEL_MEI=m
CONFIG_INTEL_MEI_ME=m
# CONFIG_INTEL_MEI_TXE is not set
# CONFIG_INTEL_MEI_HDCP is not set
CONFIG_VMWARE_VMCI=m

#
# Intel MIC & related support
#

#
# Intel MIC Bus Driver
#
# CONFIG_INTEL_MIC_BUS is not set

#
# SCIF Bus Driver
#
# CONFIG_SCIF_BUS is not set

#
# VOP Bus Driver
#
# CONFIG_VOP_BUS is not set

#
# Intel MIC Host Driver
#

#
# Intel MIC Card Driver
#

#
# SCIF Driver
#

#
# Intel MIC Coprocessor State Management (COSM) Drivers
#

#
# VOP Driver
#
# end of Intel MIC & related support

# CONFIG_GENWQE is not set
# CONFIG_ECHO is not set
# CONFIG_MISC_ALCOR_PCI is not set
# CONFIG_MISC_RTSX_PCI is not set
# CONFIG_MISC_RTSX_USB is not set
# CONFIG_HABANA_AI is not set
# end of Misc devices

CONFIG_HAVE_IDE=y
# CONFIG_IDE is not set

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=m
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
CONFIG_SCSI_NETLINK=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
CONFIG_CHR_DEV_ST=m
CONFIG_BLK_DEV_SR=m
CONFIG_BLK_DEV_SR_VENDOR=y
CONFIG_CHR_DEV_SG=m
CONFIG_CHR_DEV_SCH=m
CONFIG_SCSI_ENCLOSURE=m
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_SCAN_ASYNC=y

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=m
CONFIG_SCSI_FC_ATTRS=m
CONFIG_SCSI_ISCSI_ATTRS=m
CONFIG_SCSI_SAS_ATTRS=m
CONFIG_SCSI_SAS_LIBSAS=m
CONFIG_SCSI_SAS_ATA=y
CONFIG_SCSI_SAS_HOST_SMP=y
CONFIG_SCSI_SRP_ATTRS=m
# end of SCSI Transports

CONFIG_SCSI_LOWLEVEL=y
CONFIG_ISCSI_TCP=m
CONFIG_ISCSI_BOOT_SYSFS=m
CONFIG_SCSI_CXGB3_ISCSI=m
CONFIG_SCSI_CXGB4_ISCSI=m
CONFIG_SCSI_BNX2_ISCSI=m
CONFIG_SCSI_BNX2X_FCOE=m
CONFIG_BE2ISCSI=m
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
CONFIG_SCSI_HPSA=m
CONFIG_SCSI_3W_9XXX=m
CONFIG_SCSI_3W_SAS=m
# CONFIG_SCSI_ACARD is not set
CONFIG_SCSI_AACRAID=m
# CONFIG_SCSI_AIC7XXX is not set
CONFIG_SCSI_AIC79XX=m
CONFIG_AIC79XX_CMDS_PER_DEVICE=4
CONFIG_AIC79XX_RESET_DELAY_MS=15000
# CONFIG_AIC79XX_DEBUG_ENABLE is not set
CONFIG_AIC79XX_DEBUG_MASK=0
# CONFIG_AIC79XX_REG_PRETTY_PRINT is not set
# CONFIG_SCSI_AIC94XX is not set
CONFIG_SCSI_MVSAS=m
# CONFIG_SCSI_MVSAS_DEBUG is not set
CONFIG_SCSI_MVSAS_TASKLET=y
CONFIG_SCSI_MVUMI=m
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
CONFIG_SCSI_ARCMSR=m
# CONFIG_SCSI_ESAS2R is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
CONFIG_MEGARAID_SAS=m
CONFIG_SCSI_MPT3SAS=m
CONFIG_SCSI_MPT2SAS_MAX_SGE=128
CONFIG_SCSI_MPT3SAS_MAX_SGE=128
CONFIG_SCSI_MPT2SAS=m
# CONFIG_SCSI_SMARTPQI is not set
CONFIG_SCSI_UFSHCD=m
CONFIG_SCSI_UFSHCD_PCI=m
# CONFIG_SCSI_UFS_DWC_TC_PCI is not set
# CONFIG_SCSI_UFSHCD_PLATFORM is not set
# CONFIG_SCSI_UFS_BSG is not set
CONFIG_SCSI_HPTIOP=m
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_MYRB is not set
# CONFIG_SCSI_MYRS is not set
CONFIG_VMWARE_PVSCSI=m
# CONFIG_XEN_SCSI_FRONTEND is not set
CONFIG_HYPERV_STORAGE=m
CONFIG_LIBFC=m
CONFIG_LIBFCOE=m
CONFIG_FCOE=m
CONFIG_FCOE_FNIC=m
# CONFIG_SCSI_SNIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_FDOMAIN_PCI is not set
# CONFIG_SCSI_GDTH is not set
CONFIG_SCSI_ISCI=m
# CONFIG_SCSI_IPS is not set
CONFIG_SCSI_INITIO=m
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
CONFIG_SCSI_STEX=m
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
CONFIG_SCSI_QLA_FC=m
CONFIG_TCM_QLA2XXX=m
# CONFIG_TCM_QLA2XXX_DEBUG is not set
CONFIG_SCSI_QLA_ISCSI=m
# CONFIG_QEDI is not set
# CONFIG_QEDF is not set
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_WD719X is not set
CONFIG_SCSI_DEBUG=m
CONFIG_SCSI_PMCRAID=m
CONFIG_SCSI_PM8001=m
# CONFIG_SCSI_BFA_FC is not set
CONFIG_SCSI_VIRTIO=m
# CONFIG_SCSI_CHELSIO_FCOE is not set
CONFIG_SCSI_DH=y
CONFIG_SCSI_DH_RDAC=y
CONFIG_SCSI_DH_HP_SW=y
CONFIG_SCSI_DH_EMC=y
CONFIG_SCSI_DH_ALUA=y
# end of SCSI device support

CONFIG_ATA=y
CONFIG_ATA_VERBOSE_ERROR=y
CONFIG_ATA_ACPI=y
# CONFIG_SATA_ZPODD is not set
CONFIG_SATA_PMP=y

#
# Controllers with non-SFF native interface
#
CONFIG_SATA_AHCI=y
CONFIG_SATA_MOBILE_LPM_POLICY=0
CONFIG_SATA_AHCI_PLATFORM=y
# CONFIG_SATA_INIC162X is not set
CONFIG_SATA_ACARD_AHCI=m
CONFIG_SATA_SIL24=m
CONFIG_ATA_SFF=y

#
# SFF controllers with custom DMA interface
#
CONFIG_PDC_ADMA=m
CONFIG_SATA_QSTOR=m
CONFIG_SATA_SX4=m
CONFIG_ATA_BMDMA=y

#
# SATA SFF controllers with BMDMA
#
CONFIG_ATA_PIIX=m
# CONFIG_SATA_DWC is not set
CONFIG_SATA_MV=m
CONFIG_SATA_NV=m
CONFIG_SATA_PROMISE=m
CONFIG_SATA_SIL=m
CONFIG_SATA_SIS=m
CONFIG_SATA_SVW=m
CONFIG_SATA_ULI=m
CONFIG_SATA_VIA=m
CONFIG_SATA_VITESSE=m

#
# PATA SFF controllers with BMDMA
#
CONFIG_PATA_ALI=m
CONFIG_PATA_AMD=m
CONFIG_PATA_ARTOP=m
CONFIG_PATA_ATIIXP=m
CONFIG_PATA_ATP867X=m
CONFIG_PATA_CMD64X=m
# CONFIG_PATA_CYPRESS is not set
# CONFIG_PATA_EFAR is not set
CONFIG_PATA_HPT366=m
CONFIG_PATA_HPT37X=m
CONFIG_PATA_HPT3X2N=m
CONFIG_PATA_HPT3X3=m
# CONFIG_PATA_HPT3X3_DMA is not set
CONFIG_PATA_IT8213=m
CONFIG_PATA_IT821X=m
CONFIG_PATA_JMICRON=m
CONFIG_PATA_MARVELL=m
CONFIG_PATA_NETCELL=m
CONFIG_PATA_NINJA32=m
# CONFIG_PATA_NS87415 is not set
CONFIG_PATA_OLDPIIX=m
# CONFIG_PATA_OPTIDMA is not set
CONFIG_PATA_PDC2027X=m
CONFIG_PATA_PDC_OLD=m
# CONFIG_PATA_RADISYS is not set
CONFIG_PATA_RDC=m
CONFIG_PATA_SCH=m
CONFIG_PATA_SERVERWORKS=m
CONFIG_PATA_SIL680=m
CONFIG_PATA_SIS=m
CONFIG_PATA_TOSHIBA=m
# CONFIG_PATA_TRIFLEX is not set
CONFIG_PATA_VIA=m
# CONFIG_PATA_WINBOND is not set

#
# PIO-only SFF controllers
#
# CONFIG_PATA_CMD640_PCI is not set
# CONFIG_PATA_MPIIX is not set
# CONFIG_PATA_NS87410 is not set
# CONFIG_PATA_OPTI is not set
# CONFIG_PATA_PLATFORM is not set
# CONFIG_PATA_RZ1000 is not set

#
# Generic fallback / legacy drivers
#
CONFIG_PATA_ACPI=m
CONFIG_ATA_GENERIC=m
# CONFIG_PATA_LEGACY is not set
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_AUTODETECT=y
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID10=m
CONFIG_MD_RAID456=m
CONFIG_MD_MULTIPATH=m
CONFIG_MD_FAULTY=m
# CONFIG_MD_CLUSTER is not set
# CONFIG_BCACHE is not set
CONFIG_BLK_DEV_DM_BUILTIN=y
CONFIG_BLK_DEV_DM=m
CONFIG_DM_DEBUG=y
CONFIG_DM_BUFIO=m
# CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING is not set
CONFIG_DM_BIO_PRISON=m
CONFIG_DM_PERSISTENT_DATA=m
# CONFIG_DM_UNSTRIPED is not set
CONFIG_DM_CRYPT=m
CONFIG_DM_SNAPSHOT=m
CONFIG_DM_THIN_PROVISIONING=m
CONFIG_DM_CACHE=m
CONFIG_DM_CACHE_SMQ=m
# CONFIG_DM_WRITECACHE is not set
CONFIG_DM_ERA=m
# CONFIG_DM_CLONE is not set
CONFIG_DM_MIRROR=m
CONFIG_DM_LOG_USERSPACE=m
CONFIG_DM_RAID=m
CONFIG_DM_ZERO=m
CONFIG_DM_MULTIPATH=m
CONFIG_DM_MULTIPATH_QL=m
CONFIG_DM_MULTIPATH_ST=m
CONFIG_DM_DELAY=m
# CONFIG_DM_DUST is not set
CONFIG_DM_UEVENT=y
CONFIG_DM_FLAKEY=m
CONFIG_DM_VERITY=m
# CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG is not set
# CONFIG_DM_VERITY_FEC is not set
CONFIG_DM_SWITCH=m
CONFIG_DM_LOG_WRITES=m
# CONFIG_DM_INTEGRITY is not set
# CONFIG_DM_ZONED is not set
CONFIG_TARGET_CORE=m
CONFIG_TCM_IBLOCK=m
CONFIG_TCM_FILEIO=m
CONFIG_TCM_PSCSI=m
CONFIG_TCM_USER2=m
CONFIG_LOOPBACK_TARGET=m
CONFIG_TCM_FC=m
CONFIG_ISCSI_TARGET=m
CONFIG_ISCSI_TARGET_CXGB4=m
# CONFIG_SBP_TARGET is not set
CONFIG_FUSION=y
CONFIG_FUSION_SPI=m
# CONFIG_FUSION_FC is not set
CONFIG_FUSION_SAS=m
CONFIG_FUSION_MAX_SGE=128
CONFIG_FUSION_CTL=m
CONFIG_FUSION_LOGGING=y

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=m
CONFIG_FIREWIRE_OHCI=m
CONFIG_FIREWIRE_SBP2=m
CONFIG_FIREWIRE_NET=m
# CONFIG_FIREWIRE_NOSY is not set
# end of IEEE 1394 (FireWire) support

CONFIG_MACINTOSH_DRIVERS=y
CONFIG_MAC_EMUMOUSEBTN=y
CONFIG_NETDEVICES=y
CONFIG_MII=y
CONFIG_NET_CORE=y
CONFIG_BONDING=m
CONFIG_DUMMY=m
# CONFIG_EQUALIZER is not set
CONFIG_NET_FC=y
CONFIG_IFB=m
CONFIG_NET_TEAM=m
CONFIG_NET_TEAM_MODE_BROADCAST=m
CONFIG_NET_TEAM_MODE_ROUNDROBIN=m
CONFIG_NET_TEAM_MODE_RANDOM=m
CONFIG_NET_TEAM_MODE_ACTIVEBACKUP=m
CONFIG_NET_TEAM_MODE_LOADBALANCE=m
CONFIG_MACVLAN=m
CONFIG_MACVTAP=m
# CONFIG_IPVLAN is not set
CONFIG_VXLAN=m
CONFIG_GENEVE=m
# CONFIG_GTP is not set
CONFIG_MACSEC=y
CONFIG_NETCONSOLE=m
CONFIG_NETCONSOLE_DYNAMIC=y
CONFIG_NETPOLL=y
CONFIG_NET_POLL_CONTROLLER=y
CONFIG_NTB_NETDEV=m
CONFIG_TUN=m
CONFIG_TAP=m
# CONFIG_TUN_VNET_CROSS_LE is not set
CONFIG_VETH=m
CONFIG_VIRTIO_NET=m
CONFIG_NLMON=m
CONFIG_NET_VRF=y
CONFIG_VSOCKMON=m
# CONFIG_ARCNET is not set
# CONFIG_ATM_DRIVERS is not set

#
# CAIF transport drivers
#

#
# Distributed Switch Architecture drivers
#
# end of Distributed Switch Architecture drivers

CONFIG_ETHERNET=y
CONFIG_MDIO=y
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_NET_VENDOR_ADAPTEC is not set
CONFIG_NET_VENDOR_AGERE=y
# CONFIG_ET131X is not set
CONFIG_NET_VENDOR_ALACRITECH=y
# CONFIG_SLICOSS is not set
# CONFIG_NET_VENDOR_ALTEON is not set
# CONFIG_ALTERA_TSE is not set
CONFIG_NET_VENDOR_AMAZON=y
CONFIG_ENA_ETHERNET=m
CONFIG_NET_VENDOR_AMD=y
CONFIG_AMD8111_ETH=m
CONFIG_PCNET32=m
CONFIG_AMD_XGBE=m
# CONFIG_AMD_XGBE_DCB is not set
CONFIG_AMD_XGBE_HAVE_ECC=y
CONFIG_NET_VENDOR_AQUANTIA=y
CONFIG_AQTION=m
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ATHEROS=y
CONFIG_ATL2=m
CONFIG_ATL1=m
CONFIG_ATL1E=m
CONFIG_ATL1C=m
CONFIG_ALX=m
CONFIG_NET_VENDOR_AURORA=y
# CONFIG_AURORA_NB8800 is not set
CONFIG_NET_VENDOR_BROADCOM=y
CONFIG_B44=m
CONFIG_B44_PCI_AUTOSELECT=y
CONFIG_B44_PCICORE_AUTOSELECT=y
CONFIG_B44_PCI=y
# CONFIG_BCMGENET is not set
CONFIG_BNX2=m
CONFIG_CNIC=m
CONFIG_TIGON3=y
CONFIG_TIGON3_HWMON=y
CONFIG_BNX2X=m
CONFIG_BNX2X_SRIOV=y
# CONFIG_SYSTEMPORT is not set
CONFIG_BNXT=m
CONFIG_BNXT_SRIOV=y
CONFIG_BNXT_FLOWER_OFFLOAD=y
CONFIG_BNXT_DCB=y
CONFIG_BNXT_HWMON=y
CONFIG_NET_VENDOR_BROCADE=y
CONFIG_BNA=m
CONFIG_NET_VENDOR_CADENCE=y
CONFIG_MACB=m
CONFIG_MACB_USE_HWSTAMP=y
# CONFIG_MACB_PCI is not set
CONFIG_NET_VENDOR_CAVIUM=y
# CONFIG_THUNDER_NIC_PF is not set
# CONFIG_THUNDER_NIC_VF is not set
# CONFIG_THUNDER_NIC_BGX is not set
# CONFIG_THUNDER_NIC_RGX is not set
CONFIG_CAVIUM_PTP=y
CONFIG_LIQUIDIO=m
CONFIG_LIQUIDIO_VF=m
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
CONFIG_CHELSIO_T3=m
CONFIG_CHELSIO_T4=m
# CONFIG_CHELSIO_T4_DCB is not set
CONFIG_CHELSIO_T4VF=m
CONFIG_CHELSIO_LIB=m
CONFIG_NET_VENDOR_CISCO=y
CONFIG_ENIC=m
CONFIG_NET_VENDOR_CORTINA=y
# CONFIG_CX_ECAT is not set
CONFIG_DNET=m
CONFIG_NET_VENDOR_DEC=y
CONFIG_NET_TULIP=y
CONFIG_DE2104X=m
CONFIG_DE2104X_DSL=0
CONFIG_TULIP=y
# CONFIG_TULIP_MWI is not set
CONFIG_TULIP_MMIO=y
# CONFIG_TULIP_NAPI is not set
CONFIG_DE4X5=m
CONFIG_WINBOND_840=m
CONFIG_DM9102=m
CONFIG_ULI526X=m
CONFIG_PCMCIA_XIRCOM=m
# CONFIG_NET_VENDOR_DLINK is not set
CONFIG_NET_VENDOR_EMULEX=y
CONFIG_BE2NET=m
CONFIG_BE2NET_HWMON=y
CONFIG_BE2NET_BE2=y
CONFIG_BE2NET_BE3=y
CONFIG_BE2NET_LANCER=y
CONFIG_BE2NET_SKYHAWK=y
CONFIG_NET_VENDOR_EZCHIP=y
CONFIG_NET_VENDOR_GOOGLE=y
# CONFIG_GVE is not set
# CONFIG_NET_VENDOR_HP is not set
CONFIG_NET_VENDOR_HUAWEI=y
# CONFIG_HINIC is not set
# CONFIG_NET_VENDOR_I825XX is not set
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
CONFIG_E1000E=y
CONFIG_E1000E_HWTS=y
CONFIG_IGB=y
CONFIG_IGB_HWMON=y
CONFIG_IGBVF=m
# CONFIG_IXGB is not set
CONFIG_IXGBE=y
CONFIG_IXGBE_HWMON=y
CONFIG_IXGBE_DCB=y
CONFIG_IXGBEVF=m
CONFIG_I40E=y
CONFIG_I40E_DCB=y
CONFIG_IAVF=m
CONFIG_I40EVF=m
# CONFIG_ICE is not set
CONFIG_FM10K=m
# CONFIG_IGC is not set
CONFIG_JME=m
CONFIG_NET_VENDOR_MARVELL=y
CONFIG_MVMDIO=m
CONFIG_SKGE=y
# CONFIG_SKGE_DEBUG is not set
CONFIG_SKGE_GENESIS=y
CONFIG_SKY2=m
# CONFIG_SKY2_DEBUG is not set
CONFIG_NET_VENDOR_MELLANOX=y
CONFIG_MLX4_EN=m
CONFIG_MLX4_EN_DCB=y
CONFIG_MLX4_CORE=m
CONFIG_MLX4_DEBUG=y
CONFIG_MLX4_CORE_GEN2=y
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
# CONFIG_MLXFW is not set
# CONFIG_NET_VENDOR_MICREL is not set
# CONFIG_NET_VENDOR_MICROCHIP is not set
CONFIG_NET_VENDOR_MICROSEMI=y
# CONFIG_MSCC_OCELOT_SWITCH is not set
CONFIG_NET_VENDOR_MYRI=y
CONFIG_MYRI10GE=m
CONFIG_MYRI10GE_DCA=y
# CONFIG_FEALNX is not set
# CONFIG_NET_VENDOR_NATSEMI is not set
CONFIG_NET_VENDOR_NETERION=y
# CONFIG_S2IO is not set
# CONFIG_VXGE is not set
CONFIG_NET_VENDOR_NETRONOME=y
CONFIG_NFP=m
CONFIG_NFP_APP_FLOWER=y
CONFIG_NFP_APP_ABM_NIC=y
# CONFIG_NFP_DEBUG is not set
CONFIG_NET_VENDOR_NI=y
# CONFIG_NI_XGE_MANAGEMENT_ENET is not set
# CONFIG_NET_VENDOR_NVIDIA is not set
CONFIG_NET_VENDOR_OKI=y
CONFIG_ETHOC=m
CONFIG_NET_VENDOR_PACKET_ENGINES=y
# CONFIG_HAMACHI is not set
CONFIG_YELLOWFIN=m
CONFIG_NET_VENDOR_PENSANDO=y
# CONFIG_IONIC is not set
CONFIG_NET_VENDOR_QLOGIC=y
CONFIG_QLA3XXX=m
CONFIG_QLCNIC=m
CONFIG_QLCNIC_SRIOV=y
CONFIG_QLCNIC_DCB=y
CONFIG_QLCNIC_HWMON=y
CONFIG_NETXEN_NIC=m
CONFIG_QED=m
CONFIG_QED_SRIOV=y
CONFIG_QEDE=m
CONFIG_NET_VENDOR_QUALCOMM=y
# CONFIG_QCOM_EMAC is not set
# CONFIG_RMNET is not set
# CONFIG_NET_VENDOR_RDC is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_ATP is not set
CONFIG_8139CP=y
CONFIG_8139TOO=y
# CONFIG_8139TOO_PIO is not set
# CONFIG_8139TOO_TUNE_TWISTER is not set
CONFIG_8139TOO_8129=y
# CONFIG_8139_OLD_RX_RESET is not set
CONFIG_R8169=y
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_NET_VENDOR_ROCKER=y
CONFIG_ROCKER=m
CONFIG_NET_VENDOR_SAMSUNG=y
# CONFIG_SXGBE_ETH is not set
# CONFIG_NET_VENDOR_SEEQ is not set
CONFIG_NET_VENDOR_SOLARFLARE=y
CONFIG_SFC=m
CONFIG_SFC_MTD=y
CONFIG_SFC_MCDI_MON=y
CONFIG_SFC_SRIOV=y
CONFIG_SFC_MCDI_LOGGING=y
CONFIG_SFC_FALCON=m
CONFIG_SFC_FALCON_MTD=y
# CONFIG_NET_VENDOR_SILAN is not set
# CONFIG_NET_VENDOR_SIS is not set
CONFIG_NET_VENDOR_SMSC=y
CONFIG_EPIC100=m
# CONFIG_SMSC911X is not set
CONFIG_SMSC9420=m
CONFIG_NET_VENDOR_SOCIONEXT=y
# CONFIG_NET_VENDOR_STMICRO is not set
# CONFIG_NET_VENDOR_SUN is not set
CONFIG_NET_VENDOR_SYNOPSYS=y
# CONFIG_DWC_XLGMAC is not set
# CONFIG_NET_VENDOR_TEHUTI is not set
CONFIG_NET_VENDOR_TI=y
# CONFIG_TI_CPSW_PHY_SEL is not set
CONFIG_TLAN=m
# CONFIG_NET_VENDOR_VIA is not set
# CONFIG_NET_VENDOR_WIZNET is not set
CONFIG_NET_VENDOR_XILINX=y
# CONFIG_XILINX_AXI_EMAC is not set
# CONFIG_XILINX_LL_TEMAC is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
CONFIG_MDIO_DEVICE=y
CONFIG_MDIO_BUS=y
# CONFIG_MDIO_BCM_UNIMAC is not set
CONFIG_MDIO_BITBANG=m
# CONFIG_MDIO_GPIO is not set
# CONFIG_MDIO_MSCC_MIIM is not set
# CONFIG_MDIO_THUNDER is not set
CONFIG_PHYLIB=y
CONFIG_SWPHY=y
# CONFIG_LED_TRIGGER_PHY is not set

#
# MII PHY device drivers
#
# CONFIG_ADIN_PHY is not set
CONFIG_AMD_PHY=m
# CONFIG_AQUANTIA_PHY is not set
# CONFIG_AX88796B_PHY is not set
CONFIG_AT803X_PHY=m
# CONFIG_BCM7XXX_PHY is not set
CONFIG_BCM87XX_PHY=m
CONFIG_BCM_NET_PHYLIB=m
CONFIG_BROADCOM_PHY=m
CONFIG_CICADA_PHY=m
# CONFIG_CORTINA_PHY is not set
CONFIG_DAVICOM_PHY=m
# CONFIG_DP83822_PHY is not set
# CONFIG_DP83TC811_PHY is not set
# CONFIG_DP83848_PHY is not set
# CONFIG_DP83867_PHY is not set
CONFIG_FIXED_PHY=y
CONFIG_ICPLUS_PHY=m
# CONFIG_INTEL_XWAY_PHY is not set
CONFIG_LSI_ET1011C_PHY=m
CONFIG_LXT_PHY=m
CONFIG_MARVELL_PHY=m
# CONFIG_MARVELL_10G_PHY is not set
CONFIG_MICREL_PHY=m
# CONFIG_MICROCHIP_PHY is not set
# CONFIG_MICROCHIP_T1_PHY is not set
# CONFIG_MICROSEMI_PHY is not set
CONFIG_NATIONAL_PHY=m
# CONFIG_NXP_TJA11XX_PHY is not set
CONFIG_QSEMI_PHY=m
CONFIG_REALTEK_PHY=y
# CONFIG_RENESAS_PHY is not set
# CONFIG_ROCKCHIP_PHY is not set
CONFIG_SMSC_PHY=m
CONFIG_STE10XP=m
# CONFIG_TERANETICS_PHY is not set
CONFIG_VITESSE_PHY=m
# CONFIG_XILINX_GMII2RGMII is not set
# CONFIG_MICREL_KS8995MA is not set
# CONFIG_PLIP is not set
CONFIG_PPP=m
CONFIG_PPP_BSDCOMP=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_FILTER=y
CONFIG_PPP_MPPE=m
CONFIG_PPP_MULTILINK=y
CONFIG_PPPOATM=m
CONFIG_PPPOE=m
CONFIG_PPTP=m
CONFIG_PPPOL2TP=m
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
CONFIG_SLIP=m
CONFIG_SLHC=m
CONFIG_SLIP_COMPRESSED=y
CONFIG_SLIP_SMART=y
# CONFIG_SLIP_MODE_SLIP6 is not set
CONFIG_USB_NET_DRIVERS=y
CONFIG_USB_CATC=y
CONFIG_USB_KAWETH=y
CONFIG_USB_PEGASUS=y
CONFIG_USB_RTL8150=y
CONFIG_USB_RTL8152=m
# CONFIG_USB_LAN78XX is not set
CONFIG_USB_USBNET=y
CONFIG_USB_NET_AX8817X=y
CONFIG_USB_NET_AX88179_178A=m
CONFIG_USB_NET_CDCETHER=y
CONFIG_USB_NET_CDC_EEM=y
CONFIG_USB_NET_CDC_NCM=m
CONFIG_USB_NET_HUAWEI_CDC_NCM=m
CONFIG_USB_NET_CDC_MBIM=m
CONFIG_USB_NET_DM9601=y
# CONFIG_USB_NET_SR9700 is not set
# CONFIG_USB_NET_SR9800 is not set
CONFIG_USB_NET_SMSC75XX=y
CONFIG_USB_NET_SMSC95XX=y
CONFIG_USB_NET_GL620A=y
CONFIG_USB_NET_NET1080=y
CONFIG_USB_NET_PLUSB=y
CONFIG_USB_NET_MCS7830=y
CONFIG_USB_NET_RNDIS_HOST=y
CONFIG_USB_NET_CDC_SUBSET_ENABLE=y
CONFIG_USB_NET_CDC_SUBSET=y
CONFIG_USB_ALI_M5632=y
CONFIG_USB_AN2720=y
CONFIG_USB_BELKIN=y
CONFIG_USB_ARMLINUX=y
CONFIG_USB_EPSON2888=y
CONFIG_USB_KC2190=y
CONFIG_USB_NET_ZAURUS=y
CONFIG_USB_NET_CX82310_ETH=m
CONFIG_USB_NET_KALMIA=m
CONFIG_USB_NET_QMI_WWAN=m
CONFIG_USB_HSO=m
CONFIG_USB_NET_INT51X1=y
CONFIG_USB_IPHETH=y
CONFIG_USB_SIERRA_NET=y
CONFIG_USB_VL600=m
# CONFIG_USB_NET_CH9200 is not set
# CONFIG_USB_NET_AQC111 is not set
CONFIG_WLAN=y
# CONFIG_WIRELESS_WDS is not set
CONFIG_WLAN_VENDOR_ADMTEK=y
# CONFIG_ADM8211 is not set
CONFIG_ATH_COMMON=m
CONFIG_WLAN_VENDOR_ATH=y
# CONFIG_ATH_DEBUG is not set
# CONFIG_ATH5K is not set
# CONFIG_ATH5K_PCI is not set
CONFIG_ATH9K_HW=m
CONFIG_ATH9K_COMMON=m
CONFIG_ATH9K_BTCOEX_SUPPORT=y
# CONFIG_ATH9K is not set
CONFIG_ATH9K_HTC=m
# CONFIG_ATH9K_HTC_DEBUGFS is not set
# CONFIG_CARL9170 is not set
# CONFIG_ATH6KL is not set
# CONFIG_AR5523 is not set
# CONFIG_WIL6210 is not set
# CONFIG_ATH10K is not set
# CONFIG_WCN36XX is not set
CONFIG_WLAN_VENDOR_ATMEL=y
# CONFIG_ATMEL is not set
# CONFIG_AT76C50X_USB is not set
CONFIG_WLAN_VENDOR_BROADCOM=y
# CONFIG_B43 is not set
# CONFIG_B43LEGACY is not set
# CONFIG_BRCMSMAC is not set
# CONFIG_BRCMFMAC is not set
CONFIG_WLAN_VENDOR_CISCO=y
# CONFIG_AIRO is not set
CONFIG_WLAN_VENDOR_INTEL=y
# CONFIG_IPW2100 is not set
# CONFIG_IPW2200 is not set
CONFIG_IWLEGACY=m
CONFIG_IWL4965=m
CONFIG_IWL3945=m

#
# iwl3945 / iwl4965 Debugging Options
#
CONFIG_IWLEGACY_DEBUG=y
CONFIG_IWLEGACY_DEBUGFS=y
# end of iwl3945 / iwl4965 Debugging Options

CONFIG_IWLWIFI=m
CONFIG_IWLWIFI_LEDS=y
CONFIG_IWLDVM=m
CONFIG_IWLMVM=m
CONFIG_IWLWIFI_OPMODE_MODULAR=y
# CONFIG_IWLWIFI_BCAST_FILTERING is not set

#
# Debugging Options
#
# CONFIG_IWLWIFI_DEBUG is not set
CONFIG_IWLWIFI_DEBUGFS=y
# CONFIG_IWLWIFI_DEVICE_TRACING is not set
# end of Debugging Options

CONFIG_WLAN_VENDOR_INTERSIL=y
# CONFIG_HOSTAP is not set
# CONFIG_HERMES is not set
# CONFIG_P54_COMMON is not set
# CONFIG_PRISM54 is not set
CONFIG_WLAN_VENDOR_MARVELL=y
# CONFIG_LIBERTAS is not set
# CONFIG_LIBERTAS_THINFIRM is not set
# CONFIG_MWIFIEX is not set
# CONFIG_MWL8K is not set
CONFIG_WLAN_VENDOR_MEDIATEK=y
# CONFIG_MT7601U is not set
# CONFIG_MT76x0U is not set
# CONFIG_MT76x0E is not set
# CONFIG_MT76x2E is not set
# CONFIG_MT76x2U is not set
# CONFIG_MT7603E is not set
# CONFIG_MT7615E is not set
CONFIG_WLAN_VENDOR_RALINK=y
# CONFIG_RT2X00 is not set
CONFIG_WLAN_VENDOR_REALTEK=y
# CONFIG_RTL8180 is not set
# CONFIG_RTL8187 is not set
# CONFIG_RTL_CARDS is not set
# CONFIG_RTL8XXXU is not set
# CONFIG_RTW88 is not set
CONFIG_WLAN_VENDOR_RSI=y
# CONFIG_RSI_91X is not set
CONFIG_WLAN_VENDOR_ST=y
# CONFIG_CW1200 is not set
CONFIG_WLAN_VENDOR_TI=y
# CONFIG_WL1251 is not set
# CONFIG_WL12XX is not set
# CONFIG_WL18XX is not set
# CONFIG_WLCORE is not set
CONFIG_WLAN_VENDOR_ZYDAS=y
# CONFIG_USB_ZD1201 is not set
# CONFIG_ZD1211RW is not set
CONFIG_WLAN_VENDOR_QUANTENNA=y
# CONFIG_QTNFMAC_PCIE is not set
CONFIG_MAC80211_HWSIM=m
# CONFIG_USB_NET_RNDIS_WLAN is not set
# CONFIG_VIRT_WIFI is not set

#
# Enable WiMAX (Networking options) to see the WiMAX drivers
#
CONFIG_WAN=y
# CONFIG_LANMEDIA is not set
CONFIG_HDLC=m
CONFIG_HDLC_RAW=m
# CONFIG_HDLC_RAW_ETH is not set
CONFIG_HDLC_CISCO=m
CONFIG_HDLC_FR=m
CONFIG_HDLC_PPP=m

#
# X.25/LAPB support is disabled
#
# CONFIG_PCI200SYN is not set
# CONFIG_WANXL is not set
# CONFIG_PC300TOO is not set
# CONFIG_FARSYNC is not set
CONFIG_DLCI=m
CONFIG_DLCI_MAX=8
# CONFIG_SBNI is not set
CONFIG_IEEE802154_DRIVERS=m
CONFIG_IEEE802154_FAKELB=m
# CONFIG_IEEE802154_AT86RF230 is not set
# CONFIG_IEEE802154_MRF24J40 is not set
# CONFIG_IEEE802154_CC2520 is not set
# CONFIG_IEEE802154_ATUSB is not set
# CONFIG_IEEE802154_ADF7242 is not set
# CONFIG_IEEE802154_CA8210 is not set
# CONFIG_IEEE802154_MCR20A is not set
# CONFIG_IEEE802154_HWSIM is not set
CONFIG_XEN_NETDEV_FRONTEND=m
CONFIG_VMXNET3=m
CONFIG_FUJITSU_ES=m
CONFIG_THUNDERBOLT_NET=m
CONFIG_HYPERV_NET=m
CONFIG_NETDEVSIM=m
CONFIG_NET_FAILOVER=m
CONFIG_ISDN=y
CONFIG_ISDN_CAPI=m
# CONFIG_CAPI_TRACE is not set
CONFIG_ISDN_CAPI_CAPI20=m
CONFIG_ISDN_CAPI_MIDDLEWARE=y
CONFIG_MISDN=m
CONFIG_MISDN_DSP=m
CONFIG_MISDN_L1OIP=m

#
# mISDN hardware drivers
#
CONFIG_MISDN_HFCPCI=m
CONFIG_MISDN_HFCMULTI=m
CONFIG_MISDN_HFCUSB=m
CONFIG_MISDN_AVMFRITZ=m
CONFIG_MISDN_SPEEDFAX=m
CONFIG_MISDN_INFINEON=m
CONFIG_MISDN_W6692=m
CONFIG_MISDN_NETJET=m
CONFIG_MISDN_HDLC=m
CONFIG_MISDN_IPAC=m
CONFIG_MISDN_ISAR=m
CONFIG_NVM=y
# CONFIG_NVM_PBLK is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=y
CONFIG_INPUT_FF_MEMLESS=y
CONFIG_INPUT_POLLDEV=m
CONFIG_INPUT_SPARSEKMAP=m
# CONFIG_INPUT_MATRIXKMAP is not set

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADC is not set
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
# CONFIG_KEYBOARD_APPLESPI is not set
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_QT1050 is not set
# CONFIG_KEYBOARD_QT1070 is not set
# CONFIG_KEYBOARD_QT2160 is not set
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_GPIO is not set
# CONFIG_KEYBOARD_GPIO_POLLED is not set
# CONFIG_KEYBOARD_TCA6416 is not set
# CONFIG_KEYBOARD_TCA8418 is not set
# CONFIG_KEYBOARD_MATRIX is not set
# CONFIG_KEYBOARD_LM8323 is not set
# CONFIG_KEYBOARD_LM8333 is not set
# CONFIG_KEYBOARD_MAX7359 is not set
# CONFIG_KEYBOARD_MCS is not set
# CONFIG_KEYBOARD_MPR121 is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_OPENCORES is not set
# CONFIG_KEYBOARD_SAMSUNG is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_XTKBD is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_PS2_ALPS=y
CONFIG_MOUSE_PS2_BYD=y
CONFIG_MOUSE_PS2_LOGIPS2PP=y
CONFIG_MOUSE_PS2_SYNAPTICS=y
CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=y
CONFIG_MOUSE_PS2_CYPRESS=y
CONFIG_MOUSE_PS2_LIFEBOOK=y
CONFIG_MOUSE_PS2_TRACKPOINT=y
CONFIG_MOUSE_PS2_ELANTECH=y
CONFIG_MOUSE_PS2_ELANTECH_SMBUS=y
CONFIG_MOUSE_PS2_SENTELIC=y
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
CONFIG_MOUSE_PS2_FOCALTECH=y
CONFIG_MOUSE_PS2_VMMOUSE=y
CONFIG_MOUSE_PS2_SMBUS=y
CONFIG_MOUSE_SERIAL=m
CONFIG_MOUSE_APPLETOUCH=m
CONFIG_MOUSE_BCM5974=m
CONFIG_MOUSE_CYAPA=m
# CONFIG_MOUSE_ELAN_I2C is not set
CONFIG_MOUSE_VSXXXAA=m
# CONFIG_MOUSE_GPIO is not set
CONFIG_MOUSE_SYNAPTICS_I2C=m
CONFIG_MOUSE_SYNAPTICS_USB=m
# CONFIG_INPUT_JOYSTICK is not set
CONFIG_INPUT_TABLET=y
CONFIG_TABLET_USB_ACECAD=m
CONFIG_TABLET_USB_AIPTEK=m
CONFIG_TABLET_USB_GTCO=m
# CONFIG_TABLET_USB_HANWANG is not set
CONFIG_TABLET_USB_KBTAB=m
# CONFIG_TABLET_USB_PEGASUS is not set
# CONFIG_TABLET_SERIAL_WACOM4 is not set
CONFIG_INPUT_TOUCHSCREEN=y
CONFIG_TOUCHSCREEN_PROPERTIES=y
# CONFIG_TOUCHSCREEN_ADS7846 is not set
# CONFIG_TOUCHSCREEN_AD7877 is not set
# CONFIG_TOUCHSCREEN_AD7879 is not set
# CONFIG_TOUCHSCREEN_ADC is not set
# CONFIG_TOUCHSCREEN_ATMEL_MXT is not set
# CONFIG_TOUCHSCREEN_AUO_PIXCIR is not set
# CONFIG_TOUCHSCREEN_BU21013 is not set
# CONFIG_TOUCHSCREEN_BU21029 is not set
# CONFIG_TOUCHSCREEN_CHIPONE_ICN8505 is not set
# CONFIG_TOUCHSCREEN_CY8CTMG110 is not set
# CONFIG_TOUCHSCREEN_CYTTSP_CORE is not set
# CONFIG_TOUCHSCREEN_CYTTSP4_CORE is not set
# CONFIG_TOUCHSCREEN_DYNAPRO is not set
# CONFIG_TOUCHSCREEN_HAMPSHIRE is not set
# CONFIG_TOUCHSCREEN_EETI is not set
# CONFIG_TOUCHSCREEN_EGALAX_SERIAL is not set
# CONFIG_TOUCHSCREEN_EXC3000 is not set
# CONFIG_TOUCHSCREEN_FUJITSU is not set
# CONFIG_TOUCHSCREEN_GOODIX is not set
# CONFIG_TOUCHSCREEN_HIDEEP is not set
# CONFIG_TOUCHSCREEN_ILI210X is not set
# CONFIG_TOUCHSCREEN_S6SY761 is not set
# CONFIG_TOUCHSCREEN_GUNZE is not set
# CONFIG_TOUCHSCREEN_EKTF2127 is not set
# CONFIG_TOUCHSCREEN_ELAN is not set
CONFIG_TOUCHSCREEN_ELO=m
CONFIG_TOUCHSCREEN_WACOM_W8001=m
CONFIG_TOUCHSCREEN_WACOM_I2C=m
# CONFIG_TOUCHSCREEN_MAX11801 is not set
# CONFIG_TOUCHSCREEN_MCS5000 is not set
# CONFIG_TOUCHSCREEN_MMS114 is not set
# CONFIG_TOUCHSCREEN_MELFAS_MIP4 is not set
# CONFIG_TOUCHSCREEN_MTOUCH is not set
# CONFIG_TOUCHSCREEN_INEXIO is not set
# CONFIG_TOUCHSCREEN_MK712 is not set
# CONFIG_TOUCHSCREEN_PENMOUNT is not set
# CONFIG_TOUCHSCREEN_EDT_FT5X06 is not set
# CONFIG_TOUCHSCREEN_TOUCHRIGHT is not set
# CONFIG_TOUCHSCREEN_TOUCHWIN is not set
# CONFIG_TOUCHSCREEN_PIXCIR is not set
# CONFIG_TOUCHSCREEN_WDT87XX_I2C is not set
# CONFIG_TOUCHSCREEN_WM97XX is not set
# CONFIG_TOUCHSCREEN_USB_COMPOSITE is not set
# CONFIG_TOUCHSCREEN_TOUCHIT213 is not set
# CONFIG_TOUCHSCREEN_TSC_SERIO is not set
# CONFIG_TOUCHSCREEN_TSC2004 is not set
# CONFIG_TOUCHSCREEN_TSC2005 is not set
# CONFIG_TOUCHSCREEN_TSC2007 is not set
# CONFIG_TOUCHSCREEN_RM_TS is not set
# CONFIG_TOUCHSCREEN_SILEAD is not set
# CONFIG_TOUCHSCREEN_SIS_I2C is not set
# CONFIG_TOUCHSCREEN_ST1232 is not set
# CONFIG_TOUCHSCREEN_STMFTS is not set
# CONFIG_TOUCHSCREEN_SUR40 is not set
# CONFIG_TOUCHSCREEN_SURFACE3_SPI is not set
# CONFIG_TOUCHSCREEN_SX8654 is not set
# CONFIG_TOUCHSCREEN_TPS6507X is not set
# CONFIG_TOUCHSCREEN_ZET6223 is not set
# CONFIG_TOUCHSCREEN_ZFORCE is not set
# CONFIG_TOUCHSCREEN_ROHM_BU21023 is not set
# CONFIG_TOUCHSCREEN_IQS5XX is not set
CONFIG_INPUT_MISC=y
# CONFIG_INPUT_AD714X is not set
# CONFIG_INPUT_BMA150 is not set
# CONFIG_INPUT_E3X0_BUTTON is not set
# CONFIG_INPUT_MSM_VIBRATOR is not set
CONFIG_INPUT_PCSPKR=m
# CONFIG_INPUT_MMA8450 is not set
CONFIG_INPUT_APANEL=m
CONFIG_INPUT_GP2A=m
# CONFIG_INPUT_GPIO_BEEPER is not set
# CONFIG_INPUT_GPIO_DECODER is not set
# CONFIG_INPUT_GPIO_VIBRA is not set
CONFIG_INPUT_ATLAS_BTNS=m
CONFIG_INPUT_ATI_REMOTE2=m
CONFIG_INPUT_KEYSPAN_REMOTE=m
# CONFIG_INPUT_KXTJ9 is not set
CONFIG_INPUT_POWERMATE=m
CONFIG_INPUT_YEALINK=m
CONFIG_INPUT_CM109=m
CONFIG_INPUT_UINPUT=m
# CONFIG_INPUT_PCF8574 is not set
# CONFIG_INPUT_PWM_BEEPER is not set
# CONFIG_INPUT_PWM_VIBRA is not set
CONFIG_INPUT_GPIO_ROTARY_ENCODER=m
# CONFIG_INPUT_ADXL34X is not set
# CONFIG_INPUT_IMS_PCU is not set
# CONFIG_INPUT_CMA3000 is not set
CONFIG_INPUT_XEN_KBDDEV_FRONTEND=m
# CONFIG_INPUT_IDEAPAD_SLIDEBAR is not set
# CONFIG_INPUT_DRV260X_HAPTICS is not set
# CONFIG_INPUT_DRV2665_HAPTICS is not set
# CONFIG_INPUT_DRV2667_HAPTICS is not set
CONFIG_RMI4_CORE=m
# CONFIG_RMI4_I2C is not set
# CONFIG_RMI4_SPI is not set
CONFIG_RMI4_SMB=m
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=m
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
# CONFIG_RMI4_F34 is not set
# CONFIG_RMI4_F54 is not set
# CONFIG_RMI4_F55 is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=m
CONFIG_SERIO_ALTERA_PS2=m
# CONFIG_SERIO_PS2MULT is not set
CONFIG_SERIO_ARC_PS2=m
CONFIG_HYPERV_KEYBOARD=m
# CONFIG_SERIO_GPIO_PS2 is not set
# CONFIG_USERIO is not set
# CONFIG_GAMEPORT is not set
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
CONFIG_TTY=y
CONFIG_VT=y
CONFIG_CONSOLE_TRANSLATIONS=y
CONFIG_VT_CONSOLE=y
CONFIG_VT_CONSOLE_SLEEP=y
CONFIG_HW_CONSOLE=y
CONFIG_VT_HW_CONSOLE_BINDING=y
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
CONFIG_SERIAL_NONSTANDARD=y
# CONFIG_ROCKETPORT is not set
CONFIG_CYCLADES=m
# CONFIG_CYZ_INTR is not set
# CONFIG_MOXA_INTELLIO is not set
# CONFIG_MOXA_SMARTIO is not set
CONFIG_SYNCLINK=m
CONFIG_SYNCLINKMP=m
CONFIG_SYNCLINK_GT=m
CONFIG_NOZOMI=m
# CONFIG_ISI is not set
CONFIG_N_HDLC=m
CONFIG_N_GSM=m
# CONFIG_TRACE_SINK is not set
# CONFIG_NULL_TTY is not set
CONFIG_LDISC_AUTOLOAD=y
CONFIG_DEVMEM=y
# CONFIG_DEVKMEM is not set

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
CONFIG_SERIAL_8250_NR_UARTS=32
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
CONFIG_SERIAL_8250_SHARE_IRQ=y
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
CONFIG_SERIAL_8250_RSA=y
CONFIG_SERIAL_8250_DWLIB=y
CONFIG_SERIAL_8250_DW=y
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_MAX3100 is not set
# CONFIG_SERIAL_MAX310X is not set
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_SERIAL_JSM=m
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
# CONFIG_SERIAL_IFX6X60 is not set
CONFIG_SERIAL_ARC=m
CONFIG_SERIAL_ARC_NR_PORTS=1
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_FSL_LINFLEXUART is not set
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
# CONFIG_SERIAL_DEV_BUS is not set
# CONFIG_TTY_PRINTK is not set
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
CONFIG_PPDEV=m
CONFIG_HVC_DRIVER=y
CONFIG_HVC_IRQ=y
CONFIG_HVC_XEN=y
CONFIG_HVC_XEN_FRONTEND=y
CONFIG_VIRTIO_CONSOLE=y
CONFIG_IPMI_HANDLER=m
CONFIG_IPMI_DMI_DECODE=y
CONFIG_IPMI_PLAT_DATA=y
# CONFIG_IPMI_PANIC_EVENT is not set
CONFIG_IPMI_DEVICE_INTERFACE=m
CONFIG_IPMI_SI=m
CONFIG_IPMI_SSIF=m
CONFIG_IPMI_WATCHDOG=m
CONFIG_IPMI_POWEROFF=m
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=m
CONFIG_HW_RANDOM_INTEL=m
CONFIG_HW_RANDOM_AMD=m
CONFIG_HW_RANDOM_VIA=m
CONFIG_HW_RANDOM_VIRTIO=y
CONFIG_NVRAM=y
# CONFIG_APPLICOM is not set
# CONFIG_MWAVE is not set
CONFIG_RAW_DRIVER=y
CONFIG_MAX_RAW_DEVS=8192
CONFIG_HPET=y
CONFIG_HPET_MMAP=y
# CONFIG_HPET_MMAP_DEFAULT is not set
CONFIG_HANGCHECK_TIMER=m
CONFIG_UV_MMTIMER=m
CONFIG_TCG_TPM=y
CONFIG_HW_RANDOM_TPM=y
CONFIG_TCG_TIS_CORE=y
CONFIG_TCG_TIS=y
# CONFIG_TCG_TIS_SPI is not set
CONFIG_TCG_TIS_I2C_ATMEL=m
CONFIG_TCG_TIS_I2C_INFINEON=m
CONFIG_TCG_TIS_I2C_NUVOTON=m
CONFIG_TCG_NSC=m
CONFIG_TCG_ATMEL=m
CONFIG_TCG_INFINEON=m
# CONFIG_TCG_XEN is not set
CONFIG_TCG_CRB=y
# CONFIG_TCG_VTPM_PROXY is not set
CONFIG_TCG_TIS_ST33ZP24=m
CONFIG_TCG_TIS_ST33ZP24_I2C=m
# CONFIG_TCG_TIS_ST33ZP24_SPI is not set
CONFIG_TELCLOCK=m
CONFIG_DEVPORT=y
# CONFIG_XILLYBUS is not set
# end of Character devices

# CONFIG_RANDOM_TRUST_CPU is not set
# CONFIG_RANDOM_TRUST_BOOTLOADER is not set

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_MUX=m

#
# Multiplexer I2C Chip support
#
# CONFIG_I2C_MUX_GPIO is not set
# CONFIG_I2C_MUX_LTC4306 is not set
# CONFIG_I2C_MUX_PCA9541 is not set
# CONFIG_I2C_MUX_PCA954x is not set
# CONFIG_I2C_MUX_REG is not set
# CONFIG_I2C_MUX_MLXCPLD is not set
# end of Multiplexer I2C Chip support

CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=m
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCA=m

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
CONFIG_I2C_AMD756=m
CONFIG_I2C_AMD756_S4882=m
CONFIG_I2C_AMD8111=m
# CONFIG_I2C_AMD_MP2 is not set
CONFIG_I2C_I801=m
CONFIG_I2C_ISCH=m
CONFIG_I2C_ISMT=m
CONFIG_I2C_PIIX4=m
CONFIG_I2C_NFORCE2=m
CONFIG_I2C_NFORCE2_S4985=m
# CONFIG_I2C_NVIDIA_GPU is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
CONFIG_I2C_SIS96X=m
CONFIG_I2C_VIA=m
CONFIG_I2C_VIAPRO=m

#
# ACPI drivers
#
CONFIG_I2C_SCMI=m

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_CBUS_GPIO is not set
CONFIG_I2C_DESIGNWARE_CORE=m
CONFIG_I2C_DESIGNWARE_PLATFORM=m
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_DESIGNWARE_BAYTRAIL is not set
# CONFIG_I2C_EMEV2 is not set
# CONFIG_I2C_GPIO is not set
# CONFIG_I2C_OCORES is not set
CONFIG_I2C_PCA_PLATFORM=m
CONFIG_I2C_SIMTEC=m
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
CONFIG_I2C_DIOLAN_U2C=m
CONFIG_I2C_PARPORT=m
CONFIG_I2C_PARPORT_LIGHT=m
# CONFIG_I2C_ROBOTFUZZ_OSIF is not set
# CONFIG_I2C_TAOS_EVM is not set
CONFIG_I2C_TINY_USB=m
CONFIG_I2C_VIPERBOARD=m

#
# Other I2C/SMBus bus drivers
#
# CONFIG_I2C_MLXCPLD is not set
# end of I2C Hardware Bus support

CONFIG_I2C_STUB=m
# CONFIG_I2C_SLAVE is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

# CONFIG_I3C is not set
CONFIG_SPI=y
# CONFIG_SPI_DEBUG is not set
CONFIG_SPI_MASTER=y
# CONFIG_SPI_MEM is not set

#
# SPI Master Controller Drivers
#
# CONFIG_SPI_ALTERA is not set
# CONFIG_SPI_AXI_SPI_ENGINE is not set
# CONFIG_SPI_BITBANG is not set
# CONFIG_SPI_BUTTERFLY is not set
# CONFIG_SPI_CADENCE is not set
# CONFIG_SPI_DESIGNWARE is not set
# CONFIG_SPI_NXP_FLEXSPI is not set
# CONFIG_SPI_GPIO is not set
# CONFIG_SPI_LM70_LLP is not set
# CONFIG_SPI_OC_TINY is not set
# CONFIG_SPI_PXA2XX is not set
# CONFIG_SPI_ROCKCHIP is not set
# CONFIG_SPI_SC18IS602 is not set
# CONFIG_SPI_SIFIVE is not set
# CONFIG_SPI_MXIC is not set
# CONFIG_SPI_XCOMM is not set
# CONFIG_SPI_XILINX is not set
# CONFIG_SPI_ZYNQMP_GQSPI is not set

#
# SPI Protocol Masters
#
# CONFIG_SPI_SPIDEV is not set
# CONFIG_SPI_LOOPBACK_TEST is not set
# CONFIG_SPI_TLE62X0 is not set
# CONFIG_SPI_SLAVE is not set
# CONFIG_SPMI is not set
# CONFIG_HSI is not set
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
CONFIG_PPS_CLIENT_LDISC=m
CONFIG_PPS_CLIENT_PARPORT=m
CONFIG_PPS_CLIENT_GPIO=m

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=y
CONFIG_DP83640_PHY=m
CONFIG_PTP_1588_CLOCK_KVM=m
# end of PTP clock support

CONFIG_PINCTRL=y
CONFIG_PINMUX=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
# CONFIG_DEBUG_PINCTRL is not set
CONFIG_PINCTRL_AMD=m
# CONFIG_PINCTRL_MCP23S08 is not set
# CONFIG_PINCTRL_SX150X is not set
CONFIG_PINCTRL_BAYTRAIL=y
# CONFIG_PINCTRL_CHERRYVIEW is not set
CONFIG_PINCTRL_INTEL=m
# CONFIG_PINCTRL_BROXTON is not set
CONFIG_PINCTRL_CANNONLAKE=m
# CONFIG_PINCTRL_CEDARFORK is not set
CONFIG_PINCTRL_DENVERTON=m
CONFIG_PINCTRL_GEMINILAKE=m
# CONFIG_PINCTRL_ICELAKE is not set
CONFIG_PINCTRL_LEWISBURG=m
CONFIG_PINCTRL_SUNRISEPOINT=m
CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_GENERIC=m

#
# Memory mapped GPIO drivers
#
CONFIG_GPIO_AMDPT=m
# CONFIG_GPIO_DWAPB is not set
# CONFIG_GPIO_EXAR is not set
# CONFIG_GPIO_GENERIC_PLATFORM is not set
CONFIG_GPIO_ICH=m
# CONFIG_GPIO_LYNXPOINT is not set
# CONFIG_GPIO_MB86S7X is not set
# CONFIG_GPIO_VX855 is not set
# CONFIG_GPIO_XILINX is not set
# CONFIG_GPIO_AMD_FCH is not set
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
# CONFIG_GPIO_F7188X is not set
# CONFIG_GPIO_IT87 is not set
# CONFIG_GPIO_SCH is not set
# CONFIG_GPIO_SCH311X is not set
# CONFIG_GPIO_WINBOND is not set
# CONFIG_GPIO_WS16C48 is not set
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
# CONFIG_GPIO_ADP5588 is not set
# CONFIG_GPIO_MAX7300 is not set
# CONFIG_GPIO_MAX732X is not set
# CONFIG_GPIO_PCA953X is not set
# CONFIG_GPIO_PCF857X is not set
# CONFIG_GPIO_TPIC2810 is not set
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_PCI_IDIO_16 is not set
# CONFIG_GPIO_PCIE_IDIO_24 is not set
# CONFIG_GPIO_RDC321X is not set
# end of PCI GPIO expanders

#
# SPI GPIO expanders
#
# CONFIG_GPIO_MAX3191X is not set
# CONFIG_GPIO_MAX7301 is not set
# CONFIG_GPIO_MC33880 is not set
# CONFIG_GPIO_PISOSR is not set
# CONFIG_GPIO_XRA1403 is not set
# end of SPI GPIO expanders

#
# USB GPIO expanders
#
CONFIG_GPIO_VIPERBOARD=m
# end of USB GPIO expanders

CONFIG_GPIO_MOCKUP=y
# CONFIG_W1 is not set
# CONFIG_POWER_AVS is not set
CONFIG_POWER_RESET=y
# CONFIG_POWER_RESET_RESTART is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_POWER_SUPPLY_HWMON=y
# CONFIG_PDA_POWER is not set
# CONFIG_GENERIC_ADC_BATTERY is not set
# CONFIG_TEST_POWER is not set
# CONFIG_CHARGER_ADP5061 is not set
# CONFIG_BATTERY_DS2780 is not set
# CONFIG_BATTERY_DS2781 is not set
# CONFIG_BATTERY_DS2782 is not set
# CONFIG_BATTERY_SBS is not set
# CONFIG_CHARGER_SBS is not set
# CONFIG_MANAGER_SBS is not set
# CONFIG_BATTERY_BQ27XXX is not set
# CONFIG_BATTERY_MAX17040 is not set
# CONFIG_BATTERY_MAX17042 is not set
# CONFIG_CHARGER_MAX8903 is not set
# CONFIG_CHARGER_LP8727 is not set
# CONFIG_CHARGER_GPIO is not set
# CONFIG_CHARGER_LT3651 is not set
# CONFIG_CHARGER_BQ2415X is not set
# CONFIG_CHARGER_BQ24257 is not set
# CONFIG_CHARGER_BQ24735 is not set
# CONFIG_CHARGER_BQ25890 is not set
CONFIG_CHARGER_SMB347=m
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
# CONFIG_CHARGER_RT9455 is not set
CONFIG_HWMON=y
CONFIG_HWMON_VID=m
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
CONFIG_SENSORS_ABITUGURU=m
CONFIG_SENSORS_ABITUGURU3=m
# CONFIG_SENSORS_AD7314 is not set
CONFIG_SENSORS_AD7414=m
CONFIG_SENSORS_AD7418=m
CONFIG_SENSORS_ADM1021=m
CONFIG_SENSORS_ADM1025=m
CONFIG_SENSORS_ADM1026=m
CONFIG_SENSORS_ADM1029=m
CONFIG_SENSORS_ADM1031=m
CONFIG_SENSORS_ADM9240=m
CONFIG_SENSORS_ADT7X10=m
# CONFIG_SENSORS_ADT7310 is not set
CONFIG_SENSORS_ADT7410=m
CONFIG_SENSORS_ADT7411=m
CONFIG_SENSORS_ADT7462=m
CONFIG_SENSORS_ADT7470=m
CONFIG_SENSORS_ADT7475=m
# CONFIG_SENSORS_AS370 is not set
CONFIG_SENSORS_ASC7621=m
CONFIG_SENSORS_K8TEMP=m
CONFIG_SENSORS_K10TEMP=m
CONFIG_SENSORS_FAM15H_POWER=m
CONFIG_SENSORS_APPLESMC=m
CONFIG_SENSORS_ASB100=m
# CONFIG_SENSORS_ASPEED is not set
CONFIG_SENSORS_ATXP1=m
CONFIG_SENSORS_DS620=m
CONFIG_SENSORS_DS1621=m
CONFIG_SENSORS_DELL_SMM=m
CONFIG_SENSORS_I5K_AMB=m
CONFIG_SENSORS_F71805F=m
CONFIG_SENSORS_F71882FG=m
CONFIG_SENSORS_F75375S=m
CONFIG_SENSORS_FSCHMD=m
# CONFIG_SENSORS_FTSTEUTATES is not set
CONFIG_SENSORS_GL518SM=m
CONFIG_SENSORS_GL520SM=m
CONFIG_SENSORS_G760A=m
# CONFIG_SENSORS_G762 is not set
# CONFIG_SENSORS_HIH6130 is not set
CONFIG_SENSORS_IBMAEM=m
CONFIG_SENSORS_IBMPEX=m
# CONFIG_SENSORS_IIO_HWMON is not set
# CONFIG_SENSORS_I5500 is not set
CONFIG_SENSORS_CORETEMP=m
CONFIG_SENSORS_IT87=m
CONFIG_SENSORS_JC42=m
# CONFIG_SENSORS_POWR1220 is not set
CONFIG_SENSORS_LINEAGE=m
# CONFIG_SENSORS_LTC2945 is not set
# CONFIG_SENSORS_LTC2990 is not set
CONFIG_SENSORS_LTC4151=m
CONFIG_SENSORS_LTC4215=m
# CONFIG_SENSORS_LTC4222 is not set
CONFIG_SENSORS_LTC4245=m
# CONFIG_SENSORS_LTC4260 is not set
CONFIG_SENSORS_LTC4261=m
# CONFIG_SENSORS_MAX1111 is not set
CONFIG_SENSORS_MAX16065=m
CONFIG_SENSORS_MAX1619=m
CONFIG_SENSORS_MAX1668=m
CONFIG_SENSORS_MAX197=m
# CONFIG_SENSORS_MAX31722 is not set
# CONFIG_SENSORS_MAX6621 is not set
CONFIG_SENSORS_MAX6639=m
CONFIG_SENSORS_MAX6642=m
CONFIG_SENSORS_MAX6650=m
CONFIG_SENSORS_MAX6697=m
# CONFIG_SENSORS_MAX31790 is not set
CONFIG_SENSORS_MCP3021=m
# CONFIG_SENSORS_TC654 is not set
# CONFIG_SENSORS_ADCXX is not set
CONFIG_SENSORS_LM63=m
# CONFIG_SENSORS_LM70 is not set
CONFIG_SENSORS_LM73=m
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_LM77=m
CONFIG_SENSORS_LM78=m
CONFIG_SENSORS_LM80=m
CONFIG_SENSORS_LM83=m
CONFIG_SENSORS_LM85=m
CONFIG_SENSORS_LM87=m
CONFIG_SENSORS_LM90=m
CONFIG_SENSORS_LM92=m
CONFIG_SENSORS_LM93=m
CONFIG_SENSORS_LM95234=m
CONFIG_SENSORS_LM95241=m
CONFIG_SENSORS_LM95245=m
CONFIG_SENSORS_PC87360=m
CONFIG_SENSORS_PC87427=m
CONFIG_SENSORS_NTC_THERMISTOR=m
# CONFIG_SENSORS_NCT6683 is not set
CONFIG_SENSORS_NCT6775=m
# CONFIG_SENSORS_NCT7802 is not set
# CONFIG_SENSORS_NCT7904 is not set
# CONFIG_SENSORS_NPCM7XX is not set
CONFIG_SENSORS_PCF8591=m
CONFIG_PMBUS=m
CONFIG_SENSORS_PMBUS=m
CONFIG_SENSORS_ADM1275=m
# CONFIG_SENSORS_IBM_CFFPS is not set
# CONFIG_SENSORS_INSPUR_IPSPS is not set
# CONFIG_SENSORS_IR35221 is not set
# CONFIG_SENSORS_IR38064 is not set
# CONFIG_SENSORS_IRPS5401 is not set
# CONFIG_SENSORS_ISL68137 is not set
CONFIG_SENSORS_LM25066=m
CONFIG_SENSORS_LTC2978=m
# CONFIG_SENSORS_LTC3815 is not set
CONFIG_SENSORS_MAX16064=m
# CONFIG_SENSORS_MAX20751 is not set
# CONFIG_SENSORS_MAX31785 is not set
CONFIG_SENSORS_MAX34440=m
CONFIG_SENSORS_MAX8688=m
# CONFIG_SENSORS_PXE1610 is not set
# CONFIG_SENSORS_TPS40422 is not set
# CONFIG_SENSORS_TPS53679 is not set
CONFIG_SENSORS_UCD9000=m
CONFIG_SENSORS_UCD9200=m
CONFIG_SENSORS_ZL6100=m
CONFIG_SENSORS_SHT15=m
CONFIG_SENSORS_SHT21=m
# CONFIG_SENSORS_SHT3x is not set
# CONFIG_SENSORS_SHTC1 is not set
CONFIG_SENSORS_SIS5595=m
CONFIG_SENSORS_DME1737=m
CONFIG_SENSORS_EMC1403=m
# CONFIG_SENSORS_EMC2103 is not set
CONFIG_SENSORS_EMC6W201=m
CONFIG_SENSORS_SMSC47M1=m
CONFIG_SENSORS_SMSC47M192=m
CONFIG_SENSORS_SMSC47B397=m
CONFIG_SENSORS_SCH56XX_COMMON=m
CONFIG_SENSORS_SCH5627=m
CONFIG_SENSORS_SCH5636=m
# CONFIG_SENSORS_STTS751 is not set
# CONFIG_SENSORS_SMM665 is not set
# CONFIG_SENSORS_ADC128D818 is not set
CONFIG_SENSORS_ADS7828=m
# CONFIG_SENSORS_ADS7871 is not set
CONFIG_SENSORS_AMC6821=m
CONFIG_SENSORS_INA209=m
CONFIG_SENSORS_INA2XX=m
# CONFIG_SENSORS_INA3221 is not set
# CONFIG_SENSORS_TC74 is not set
CONFIG_SENSORS_THMC50=m
CONFIG_SENSORS_TMP102=m
# CONFIG_SENSORS_TMP103 is not set
# CONFIG_SENSORS_TMP108 is not set
CONFIG_SENSORS_TMP401=m
CONFIG_SENSORS_TMP421=m
CONFIG_SENSORS_VIA_CPUTEMP=m
CONFIG_SENSORS_VIA686A=m
CONFIG_SENSORS_VT1211=m
CONFIG_SENSORS_VT8231=m
# CONFIG_SENSORS_W83773G is not set
CONFIG_SENSORS_W83781D=m
CONFIG_SENSORS_W83791D=m
CONFIG_SENSORS_W83792D=m
CONFIG_SENSORS_W83793=m
CONFIG_SENSORS_W83795=m
# CONFIG_SENSORS_W83795_FANCTRL is not set
CONFIG_SENSORS_W83L785TS=m
CONFIG_SENSORS_W83L786NG=m
CONFIG_SENSORS_W83627HF=m
CONFIG_SENSORS_W83627EHF=m
# CONFIG_SENSORS_XGENE is not set

#
# ACPI drivers
#
CONFIG_SENSORS_ACPI_POWER=m
CONFIG_SENSORS_ATK0110=m
CONFIG_THERMAL=y
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
CONFIG_THERMAL_WRITABLE_TRIPS=y
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
# CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
CONFIG_THERMAL_GOV_STEP_WISE=y
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
# CONFIG_THERMAL_GOV_POWER_ALLOCATOR is not set
# CONFIG_CLOCK_THERMAL is not set
# CONFIG_DEVFREQ_THERMAL is not set
# CONFIG_THERMAL_EMULATION is not set

#
# Intel thermal drivers
#
CONFIG_INTEL_POWERCLAMP=m
CONFIG_X86_PKG_TEMP_THERMAL=m
CONFIG_INTEL_SOC_DTS_IOSF_CORE=m
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
CONFIG_INT340X_THERMAL=m
CONFIG_ACPI_THERMAL_REL=m
# CONFIG_INT3406_THERMAL is not set
CONFIG_PROC_THERMAL_MMIO_RAPL=y
# end of ACPI INT340X thermal drivers

# CONFIG_INTEL_PCH_THERMAL is not set
# end of Intel thermal drivers

# CONFIG_GENERIC_ADC_THERMAL is not set
CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=y
CONFIG_WATCHDOG_OPEN_TIMEOUT=0
CONFIG_WATCHDOG_SYSFS=y

#
# Watchdog Pretimeout Governors
#
# CONFIG_WATCHDOG_PRETIMEOUT_GOV is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=m
CONFIG_WDAT_WDT=m
# CONFIG_XILINX_WATCHDOG is not set
# CONFIG_ZIIRAVE_WATCHDOG is not set
# CONFIG_CADENCE_WATCHDOG is not set
# CONFIG_DW_WATCHDOG is not set
# CONFIG_MAX63XX_WATCHDOG is not set
# CONFIG_ACQUIRE_WDT is not set
# CONFIG_ADVANTECH_WDT is not set
CONFIG_ALIM1535_WDT=m
CONFIG_ALIM7101_WDT=m
# CONFIG_EBC_C384_WDT is not set
CONFIG_F71808E_WDT=m
CONFIG_SP5100_TCO=m
CONFIG_SBC_FITPC2_WATCHDOG=m
# CONFIG_EUROTECH_WDT is not set
CONFIG_IB700_WDT=m
CONFIG_IBMASR=m
# CONFIG_WAFER_WDT is not set
CONFIG_I6300ESB_WDT=y
CONFIG_IE6XX_WDT=m
CONFIG_ITCO_WDT=y
CONFIG_ITCO_VENDOR_SUPPORT=y
CONFIG_IT8712F_WDT=m
CONFIG_IT87_WDT=m
CONFIG_HP_WATCHDOG=m
CONFIG_HPWDT_NMI_DECODING=y
# CONFIG_SC1200_WDT is not set
# CONFIG_PC87413_WDT is not set
CONFIG_NV_TCO=m
# CONFIG_60XX_WDT is not set
# CONFIG_CPU5_WDT is not set
CONFIG_SMSC_SCH311X_WDT=m
# CONFIG_SMSC37B787_WDT is not set
# CONFIG_TQMX86_WDT is not set
CONFIG_VIA_WDT=m
CONFIG_W83627HF_WDT=m
CONFIG_W83877F_WDT=m
CONFIG_W83977F_WDT=m
CONFIG_MACHZ_WDT=m
# CONFIG_SBC_EPX_C3_WATCHDOG is not set
CONFIG_INTEL_MEI_WDT=m
# CONFIG_NI903X_WDT is not set
# CONFIG_NIC7018_WDT is not set
# CONFIG_MEN_A21_WDT is not set
CONFIG_XEN_WDT=m

#
# PCI-based Watchdog Cards
#
CONFIG_PCIPCWATCHDOG=m
CONFIG_WDTPCI=m

#
# USB-based Watchdog Cards
#
CONFIG_USBPCWATCHDOG=m
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB=m
CONFIG_SSB_SPROM=y
CONFIG_SSB_PCIHOST_POSSIBLE=y
CONFIG_SSB_PCIHOST=y
CONFIG_SSB_SDIOHOST_POSSIBLE=y
CONFIG_SSB_SDIOHOST=y
CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=y
CONFIG_SSB_DRIVER_PCICORE=y
CONFIG_SSB_DRIVER_GPIO=y
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=m
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
CONFIG_BCMA_HOST_PCI=y
# CONFIG_BCMA_HOST_SOC is not set
CONFIG_BCMA_DRIVER_PCI=y
CONFIG_BCMA_DRIVER_GMAC_CMN=y
CONFIG_BCMA_DRIVER_GPIO=y
# CONFIG_BCMA_DEBUG is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_AS3711 is not set
# CONFIG_PMIC_ADP5520 is not set
# CONFIG_MFD_AAT2870_CORE is not set
# CONFIG_MFD_BCM590XX is not set
# CONFIG_MFD_BD9571MWV is not set
# CONFIG_MFD_AXP20X_I2C is not set
# CONFIG_MFD_MADERA is not set
# CONFIG_PMIC_DA903X is not set
# CONFIG_MFD_DA9052_SPI is not set
# CONFIG_MFD_DA9052_I2C is not set
# CONFIG_MFD_DA9055 is not set
# CONFIG_MFD_DA9062 is not set
# CONFIG_MFD_DA9063 is not set
# CONFIG_MFD_DA9150 is not set
# CONFIG_MFD_DLN2 is not set
# CONFIG_MFD_MC13XXX_SPI is not set
# CONFIG_MFD_MC13XXX_I2C is not set
# CONFIG_HTC_PASIC3 is not set
# CONFIG_HTC_I2CPLD is not set
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
CONFIG_LPC_ICH=m
CONFIG_LPC_SCH=m
# CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
CONFIG_MFD_INTEL_LPSS=y
CONFIG_MFD_INTEL_LPSS_ACPI=y
CONFIG_MFD_INTEL_LPSS_PCI=y
# CONFIG_MFD_JANZ_CMODIO is not set
# CONFIG_MFD_KEMPLD is not set
# CONFIG_MFD_88PM800 is not set
# CONFIG_MFD_88PM805 is not set
# CONFIG_MFD_88PM860X is not set
# CONFIG_MFD_MAX14577 is not set
# CONFIG_MFD_MAX77693 is not set
# CONFIG_MFD_MAX77843 is not set
# CONFIG_MFD_MAX8907 is not set
# CONFIG_MFD_MAX8925 is not set
# CONFIG_MFD_MAX8997 is not set
# CONFIG_MFD_MAX8998 is not set
# CONFIG_MFD_MT6397 is not set
# CONFIG_MFD_MENF21BMC is not set
# CONFIG_EZX_PCAP is not set
CONFIG_MFD_VIPERBOARD=m
# CONFIG_MFD_RETU is not set
# CONFIG_MFD_PCF50633 is not set
# CONFIG_UCB1400_CORE is not set
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_RT5033 is not set
# CONFIG_MFD_RC5T583 is not set
# CONFIG_MFD_SEC_CORE is not set
# CONFIG_MFD_SI476X_CORE is not set
CONFIG_MFD_SM501=m
CONFIG_MFD_SM501_GPIO=y
# CONFIG_MFD_SKY81452 is not set
# CONFIG_MFD_SMSC is not set
# CONFIG_ABX500_CORE is not set
# CONFIG_MFD_SYSCON is not set
# CONFIG_MFD_TI_AM335X_TSCADC is not set
# CONFIG_MFD_LP3943 is not set
# CONFIG_MFD_LP8788 is not set
# CONFIG_MFD_TI_LMU is not set
# CONFIG_MFD_PALMAS is not set
# CONFIG_TPS6105X is not set
# CONFIG_TPS65010 is not set
# CONFIG_TPS6507X is not set
# CONFIG_MFD_TPS65086 is not set
# CONFIG_MFD_TPS65090 is not set
# CONFIG_MFD_TI_LP873X is not set
# CONFIG_MFD_TPS6586X is not set
# CONFIG_MFD_TPS65910 is not set
# CONFIG_MFD_TPS65912_I2C is not set
# CONFIG_MFD_TPS65912_SPI is not set
# CONFIG_MFD_TPS80031 is not set
# CONFIG_TWL4030_CORE is not set
# CONFIG_TWL6040_CORE is not set
# CONFIG_MFD_WL1273_CORE is not set
# CONFIG_MFD_LM3533 is not set
# CONFIG_MFD_TQMX86 is not set
CONFIG_MFD_VX855=m
# CONFIG_MFD_ARIZONA_I2C is not set
# CONFIG_MFD_ARIZONA_SPI is not set
# CONFIG_MFD_WM8400 is not set
# CONFIG_MFD_WM831X_I2C is not set
# CONFIG_MFD_WM831X_SPI is not set
# CONFIG_MFD_WM8350_I2C is not set
# CONFIG_MFD_WM8994 is not set
# end of Multifunction device drivers

# CONFIG_REGULATOR is not set
CONFIG_RC_CORE=m
CONFIG_RC_MAP=m
CONFIG_LIRC=y
CONFIG_RC_DECODERS=y
CONFIG_IR_NEC_DECODER=m
CONFIG_IR_RC5_DECODER=m
CONFIG_IR_RC6_DECODER=m
CONFIG_IR_JVC_DECODER=m
CONFIG_IR_SONY_DECODER=m
CONFIG_IR_SANYO_DECODER=m
CONFIG_IR_SHARP_DECODER=m
CONFIG_IR_MCE_KBD_DECODER=m
# CONFIG_IR_XMP_DECODER is not set
CONFIG_IR_IMON_DECODER=m
# CONFIG_IR_RCMM_DECODER is not set
CONFIG_RC_DEVICES=y
CONFIG_RC_ATI_REMOTE=m
CONFIG_IR_ENE=m
CONFIG_IR_IMON=m
# CONFIG_IR_IMON_RAW is not set
CONFIG_IR_MCEUSB=m
CONFIG_IR_ITE_CIR=m
CONFIG_IR_FINTEK=m
CONFIG_IR_NUVOTON=m
CONFIG_IR_REDRAT3=m
CONFIG_IR_STREAMZAP=m
CONFIG_IR_WINBOND_CIR=m
# CONFIG_IR_IGORPLUGUSB is not set
CONFIG_IR_IGUANA=m
CONFIG_IR_TTUSBIR=m
CONFIG_RC_LOOPBACK=m
# CONFIG_IR_SERIAL is not set
# CONFIG_IR_SIR is not set
# CONFIG_RC_XBOX_DVD is not set
CONFIG_MEDIA_SUPPORT=m

#
# Multimedia core support
#
CONFIG_MEDIA_CAMERA_SUPPORT=y
CONFIG_MEDIA_ANALOG_TV_SUPPORT=y
CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
CONFIG_MEDIA_RADIO_SUPPORT=y
# CONFIG_MEDIA_SDR_SUPPORT is not set
# CONFIG_MEDIA_CEC_SUPPORT is not set
CONFIG_MEDIA_CONTROLLER=y
CONFIG_MEDIA_CONTROLLER_DVB=y
CONFIG_VIDEO_DEV=m
# CONFIG_VIDEO_V4L2_SUBDEV_API is not set
CONFIG_VIDEO_V4L2=m
CONFIG_VIDEO_V4L2_I2C=y
# CONFIG_VIDEO_ADV_DEBUG is not set
# CONFIG_VIDEO_FIXED_MINOR_RANGES is not set
CONFIG_VIDEO_TUNER=m
CONFIG_VIDEOBUF_GEN=m
CONFIG_VIDEOBUF_DMA_SG=m
CONFIG_VIDEOBUF_VMALLOC=m
CONFIG_DVB_CORE=m
# CONFIG_DVB_MMAP is not set
CONFIG_DVB_NET=y
CONFIG_TTPCI_EEPROM=m
CONFIG_DVB_MAX_ADAPTERS=8
CONFIG_DVB_DYNAMIC_MINORS=y
# CONFIG_DVB_DEMUX_SECTION_LOSS_LOG is not set
# CONFIG_DVB_ULE_DEBUG is not set

#
# Media drivers
#
CONFIG_MEDIA_USB_SUPPORT=y

#
# Webcam devices
#
CONFIG_USB_VIDEO_CLASS=m
CONFIG_USB_VIDEO_CLASS_INPUT_EVDEV=y
CONFIG_USB_GSPCA=m
CONFIG_USB_M5602=m
CONFIG_USB_STV06XX=m
CONFIG_USB_GL860=m
CONFIG_USB_GSPCA_BENQ=m
CONFIG_USB_GSPCA_CONEX=m
CONFIG_USB_GSPCA_CPIA1=m
# CONFIG_USB_GSPCA_DTCS033 is not set
CONFIG_USB_GSPCA_ETOMS=m
CONFIG_USB_GSPCA_FINEPIX=m
CONFIG_USB_GSPCA_JEILINJ=m
CONFIG_USB_GSPCA_JL2005BCD=m
# CONFIG_USB_GSPCA_KINECT is not set
CONFIG_USB_GSPCA_KONICA=m
CONFIG_USB_GSPCA_MARS=m
CONFIG_USB_GSPCA_MR97310A=m
CONFIG_USB_GSPCA_NW80X=m
CONFIG_USB_GSPCA_OV519=m
CONFIG_USB_GSPCA_OV534=m
CONFIG_USB_GSPCA_OV534_9=m
CONFIG_USB_GSPCA_PAC207=m
CONFIG_USB_GSPCA_PAC7302=m
CONFIG_USB_GSPCA_PAC7311=m
CONFIG_USB_GSPCA_SE401=m
CONFIG_USB_GSPCA_SN9C2028=m
CONFIG_USB_GSPCA_SN9C20X=m
CONFIG_USB_GSPCA_SONIXB=m
CONFIG_USB_GSPCA_SONIXJ=m
CONFIG_USB_GSPCA_SPCA500=m
CONFIG_USB_GSPCA_SPCA501=m
CONFIG_USB_GSPCA_SPCA505=m
CONFIG_USB_GSPCA_SPCA506=m
CONFIG_USB_GSPCA_SPCA508=m
CONFIG_USB_GSPCA_SPCA561=m
CONFIG_USB_GSPCA_SPCA1528=m
CONFIG_USB_GSPCA_SQ905=m
CONFIG_USB_GSPCA_SQ905C=m
CONFIG_USB_GSPCA_SQ930X=m
CONFIG_USB_GSPCA_STK014=m
# CONFIG_USB_GSPCA_STK1135 is not set
CONFIG_USB_GSPCA_STV0680=m
CONFIG_USB_GSPCA_SUNPLUS=m
CONFIG_USB_GSPCA_T613=m
CONFIG_USB_GSPCA_TOPRO=m
# CONFIG_USB_GSPCA_TOUPTEK is not set
CONFIG_USB_GSPCA_TV8532=m
CONFIG_USB_GSPCA_VC032X=m
CONFIG_USB_GSPCA_VICAM=m
CONFIG_USB_GSPCA_XIRLINK_CIT=m
CONFIG_USB_GSPCA_ZC3XX=m
CONFIG_USB_PWC=m
# CONFIG_USB_PWC_DEBUG is not set
CONFIG_USB_PWC_INPUT_EVDEV=y
# CONFIG_VIDEO_CPIA2 is not set
CONFIG_USB_ZR364XX=m
CONFIG_USB_STKWEBCAM=m
CONFIG_USB_S2255=m
# CONFIG_VIDEO_USBTV is not set

#
# Analog TV USB devices
#
CONFIG_VIDEO_PVRUSB2=m
CONFIG_VIDEO_PVRUSB2_SYSFS=y
CONFIG_VIDEO_PVRUSB2_DVB=y
# CONFIG_VIDEO_PVRUSB2_DEBUGIFC is not set
CONFIG_VIDEO_HDPVR=m
CONFIG_VIDEO_USBVISION=m
# CONFIG_VIDEO_STK1160_COMMON is not set
# CONFIG_VIDEO_GO7007 is not set

#
# Analog/digital TV USB devices
#
CONFIG_VIDEO_AU0828=m
CONFIG_VIDEO_AU0828_V4L2=y
# CONFIG_VIDEO_AU0828_RC is not set
CONFIG_VIDEO_CX231XX=m
CONFIG_VIDEO_CX231XX_RC=y
CONFIG_VIDEO_CX231XX_ALSA=m
CONFIG_VIDEO_CX231XX_DVB=m
CONFIG_VIDEO_TM6000=m
CONFIG_VIDEO_TM6000_ALSA=m
CONFIG_VIDEO_TM6000_DVB=m

#
# Digital TV USB devices
#
CONFIG_DVB_USB=m
# CONFIG_DVB_USB_DEBUG is not set
CONFIG_DVB_USB_DIB3000MC=m
CONFIG_DVB_USB_A800=m
CONFIG_DVB_USB_DIBUSB_MB=m
# CONFIG_DVB_USB_DIBUSB_MB_FAULTY is not set
CONFIG_DVB_USB_DIBUSB_MC=m
CONFIG_DVB_USB_DIB0700=m
CONFIG_DVB_USB_UMT_010=m
CONFIG_DVB_USB_CXUSB=m
# CONFIG_DVB_USB_CXUSB_ANALOG is not set
CONFIG_DVB_USB_M920X=m
CONFIG_DVB_USB_DIGITV=m
CONFIG_DVB_USB_VP7045=m
CONFIG_DVB_USB_VP702X=m
CONFIG_DVB_USB_GP8PSK=m
CONFIG_DVB_USB_NOVA_T_USB2=m
CONFIG_DVB_USB_TTUSB2=m
CONFIG_DVB_USB_DTT200U=m
CONFIG_DVB_USB_OPERA1=m
CONFIG_DVB_USB_AF9005=m
CONFIG_DVB_USB_AF9005_REMOTE=m
CONFIG_DVB_USB_PCTV452E=m
CONFIG_DVB_USB_DW2102=m
CONFIG_DVB_USB_CINERGY_T2=m
CONFIG_DVB_USB_DTV5100=m
CONFIG_DVB_USB_AZ6027=m
CONFIG_DVB_USB_TECHNISAT_USB2=m
CONFIG_DVB_USB_V2=m
CONFIG_DVB_USB_AF9015=m
CONFIG_DVB_USB_AF9035=m
CONFIG_DVB_USB_ANYSEE=m
CONFIG_DVB_USB_AU6610=m
CONFIG_DVB_USB_AZ6007=m
CONFIG_DVB_USB_CE6230=m
CONFIG_DVB_USB_EC168=m
CONFIG_DVB_USB_GL861=m
CONFIG_DVB_USB_LME2510=m
CONFIG_DVB_USB_MXL111SF=m
CONFIG_DVB_USB_RTL28XXU=m
# CONFIG_DVB_USB_DVBSKY is not set
# CONFIG_DVB_USB_ZD1301 is not set
CONFIG_DVB_TTUSB_BUDGET=m
CONFIG_DVB_TTUSB_DEC=m
CONFIG_SMS_USB_DRV=m
CONFIG_DVB_B2C2_FLEXCOP_USB=m
# CONFIG_DVB_B2C2_FLEXCOP_USB_DEBUG is not set
# CONFIG_DVB_AS102 is not set

#
# Webcam, TV (analog/digital) USB devices
#
CONFIG_VIDEO_EM28XX=m
# CONFIG_VIDEO_EM28XX_V4L2 is not set
CONFIG_VIDEO_EM28XX_ALSA=m
CONFIG_VIDEO_EM28XX_DVB=m
CONFIG_VIDEO_EM28XX_RC=m
CONFIG_MEDIA_PCI_SUPPORT=y

#
# Media capture support
#
# CONFIG_VIDEO_MEYE is not set
# CONFIG_VIDEO_SOLO6X10 is not set
# CONFIG_VIDEO_TW5864 is not set
# CONFIG_VIDEO_TW68 is not set
# CONFIG_VIDEO_TW686X is not set

#
# Media capture/analog TV support
#
CONFIG_VIDEO_IVTV=m
# CONFIG_VIDEO_IVTV_DEPRECATED_IOCTLS is not set
# CONFIG_VIDEO_IVTV_ALSA is not set
CONFIG_VIDEO_FB_IVTV=m
# CONFIG_VIDEO_FB_IVTV_FORCE_PAT is not set
# CONFIG_VIDEO_HEXIUM_GEMINI is not set
# CONFIG_VIDEO_HEXIUM_ORION is not set
# CONFIG_VIDEO_MXB is not set
# CONFIG_VIDEO_DT3155 is not set

#
# Media capture/analog/hybrid TV support
#
CONFIG_VIDEO_CX18=m
CONFIG_VIDEO_CX18_ALSA=m
CONFIG_VIDEO_CX23885=m
CONFIG_MEDIA_ALTERA_CI=m
# CONFIG_VIDEO_CX25821 is not set
CONFIG_VIDEO_CX88=m
CONFIG_VIDEO_CX88_ALSA=m
CONFIG_VIDEO_CX88_BLACKBIRD=m
CONFIG_VIDEO_CX88_DVB=m
CONFIG_VIDEO_CX88_ENABLE_VP3054=y
CONFIG_VIDEO_CX88_VP3054=m
CONFIG_VIDEO_CX88_MPEG=m
CONFIG_VIDEO_BT848=m
CONFIG_DVB_BT8XX=m
CONFIG_VIDEO_SAA7134=m
CONFIG_VIDEO_SAA7134_ALSA=m
CONFIG_VIDEO_SAA7134_RC=y
CONFIG_VIDEO_SAA7134_DVB=m
CONFIG_VIDEO_SAA7164=m

#
# Media digital TV PCI Adapters
#
CONFIG_DVB_AV7110_IR=y
CONFIG_DVB_AV7110=m
CONFIG_DVB_AV7110_OSD=y
CONFIG_DVB_BUDGET_CORE=m
CONFIG_DVB_BUDGET=m
CONFIG_DVB_BUDGET_CI=m
CONFIG_DVB_BUDGET_AV=m
CONFIG_DVB_BUDGET_PATCH=m
CONFIG_DVB_B2C2_FLEXCOP_PCI=m
# CONFIG_DVB_B2C2_FLEXCOP_PCI_DEBUG is not set
CONFIG_DVB_PLUTO2=m
CONFIG_DVB_DM1105=m
CONFIG_DVB_PT1=m
# CONFIG_DVB_PT3 is not set
CONFIG_MANTIS_CORE=m
CONFIG_DVB_MANTIS=m
CONFIG_DVB_HOPPER=m
CONFIG_DVB_NGENE=m
CONFIG_DVB_DDBRIDGE=m
# CONFIG_DVB_DDBRIDGE_MSIENABLE is not set
# CONFIG_DVB_SMIPCIE is not set
# CONFIG_DVB_NETUP_UNIDVB is not set
# CONFIG_V4L_PLATFORM_DRIVERS is not set
# CONFIG_V4L_MEM2MEM_DRIVERS is not set
# CONFIG_V4L_TEST_DRIVERS is not set
# CONFIG_DVB_PLATFORM_DRIVERS is not set

#
# Supported MMC/SDIO adapters
#
CONFIG_SMS_SDIO_DRV=m
CONFIG_RADIO_ADAPTERS=y
CONFIG_RADIO_TEA575X=m
# CONFIG_RADIO_SI470X is not set
# CONFIG_RADIO_SI4713 is not set
# CONFIG_USB_MR800 is not set
# CONFIG_USB_DSBR is not set
# CONFIG_RADIO_MAXIRADIO is not set
# CONFIG_RADIO_SHARK is not set
# CONFIG_RADIO_SHARK2 is not set
# CONFIG_USB_KEENE is not set
# CONFIG_USB_RAREMONO is not set
# CONFIG_USB_MA901 is not set
# CONFIG_RADIO_TEA5764 is not set
# CONFIG_RADIO_SAA7706H is not set
# CONFIG_RADIO_TEF6862 is not set
# CONFIG_RADIO_WL1273 is not set

#
# Texas Instruments WL128x FM driver (ST based)
#
# end of Texas Instruments WL128x FM driver (ST based)

#
# Supported FireWire (IEEE 1394) Adapters
#
CONFIG_DVB_FIREDTV=m
CONFIG_DVB_FIREDTV_INPUT=y
CONFIG_MEDIA_COMMON_OPTIONS=y

#
# common driver options
#
CONFIG_VIDEO_CX2341X=m
CONFIG_VIDEO_TVEEPROM=m
CONFIG_CYPRESS_FIRMWARE=m
CONFIG_VIDEOBUF2_CORE=m
CONFIG_VIDEOBUF2_V4L2=m
CONFIG_VIDEOBUF2_MEMOPS=m
CONFIG_VIDEOBUF2_VMALLOC=m
CONFIG_VIDEOBUF2_DMA_SG=m
CONFIG_VIDEOBUF2_DVB=m
CONFIG_DVB_B2C2_FLEXCOP=m
CONFIG_VIDEO_SAA7146=m
CONFIG_VIDEO_SAA7146_VV=m
CONFIG_SMS_SIANO_MDTV=m
CONFIG_SMS_SIANO_RC=y
# CONFIG_SMS_SIANO_DEBUGFS is not set

#
# Media ancillary drivers (tuners, sensors, i2c, spi, frontends)
#
CONFIG_MEDIA_SUBDRV_AUTOSELECT=y
CONFIG_MEDIA_ATTACH=y
CONFIG_VIDEO_IR_I2C=m

#
# I2C Encoders, decoders, sensors and other helper chips
#

#
# Audio decoders, processors and mixers
#
CONFIG_VIDEO_TVAUDIO=m
CONFIG_VIDEO_TDA7432=m
# CONFIG_VIDEO_TDA9840 is not set
# CONFIG_VIDEO_TEA6415C is not set
# CONFIG_VIDEO_TEA6420 is not set
CONFIG_VIDEO_MSP3400=m
CONFIG_VIDEO_CS3308=m
CONFIG_VIDEO_CS5345=m
CONFIG_VIDEO_CS53L32A=m
# CONFIG_VIDEO_TLV320AIC23B is not set
# CONFIG_VIDEO_UDA1342 is not set
CONFIG_VIDEO_WM8775=m
CONFIG_VIDEO_WM8739=m
CONFIG_VIDEO_VP27SMPX=m
# CONFIG_VIDEO_SONY_BTF_MPX is not set

#
# RDS decoders
#
CONFIG_VIDEO_SAA6588=m

#
# Video decoders
#
# CONFIG_VIDEO_ADV7183 is not set
# CONFIG_VIDEO_BT819 is not set
# CONFIG_VIDEO_BT856 is not set
# CONFIG_VIDEO_BT866 is not set
# CONFIG_VIDEO_KS0127 is not set
# CONFIG_VIDEO_ML86V7667 is not set
# CONFIG_VIDEO_SAA7110 is not set
CONFIG_VIDEO_SAA711X=m
# CONFIG_VIDEO_TVP514X is not set
# CONFIG_VIDEO_TVP5150 is not set
# CONFIG_VIDEO_TVP7002 is not set
# CONFIG_VIDEO_TW2804 is not set
# CONFIG_VIDEO_TW9903 is not set
# CONFIG_VIDEO_TW9906 is not set
# CONFIG_VIDEO_TW9910 is not set
# CONFIG_VIDEO_VPX3220 is not set

#
# Video and audio decoders
#
CONFIG_VIDEO_SAA717X=m
CONFIG_VIDEO_CX25840=m

#
# Video encoders
#
CONFIG_VIDEO_SAA7127=m
# CONFIG_VIDEO_SAA7185 is not set
# CONFIG_VIDEO_ADV7170 is not set
# CONFIG_VIDEO_ADV7175 is not set
# CONFIG_VIDEO_ADV7343 is not set
# CONFIG_VIDEO_ADV7393 is not set
# CONFIG_VIDEO_AK881X is not set
# CONFIG_VIDEO_THS8200 is not set

#
# Camera sensor devices
#
# CONFIG_VIDEO_OV2640 is not set
# CONFIG_VIDEO_OV2659 is not set
# CONFIG_VIDEO_OV2680 is not set
# CONFIG_VIDEO_OV2685 is not set
# CONFIG_VIDEO_OV6650 is not set
# CONFIG_VIDEO_OV5695 is not set
# CONFIG_VIDEO_OV772X is not set
# CONFIG_VIDEO_OV7640 is not set
# CONFIG_VIDEO_OV7670 is not set
# CONFIG_VIDEO_OV7740 is not set
# CONFIG_VIDEO_OV9640 is not set
# CONFIG_VIDEO_VS6624 is not set
# CONFIG_VIDEO_MT9M111 is not set
# CONFIG_VIDEO_MT9T112 is not set
# CONFIG_VIDEO_MT9V011 is not set
# CONFIG_VIDEO_MT9V111 is not set
# CONFIG_VIDEO_SR030PC30 is not set
# CONFIG_VIDEO_RJ54N1 is not set

#
# Lens drivers
#
# CONFIG_VIDEO_AD5820 is not set

#
# Flash devices
#
# CONFIG_VIDEO_ADP1653 is not set
# CONFIG_VIDEO_LM3560 is not set
# CONFIG_VIDEO_LM3646 is not set

#
# Video improvement chips
#
CONFIG_VIDEO_UPD64031A=m
CONFIG_VIDEO_UPD64083=m

#
# Audio/Video compression chips
#
CONFIG_VIDEO_SAA6752HS=m

#
# SDR tuner chips
#

#
# Miscellaneous helper chips
#
# CONFIG_VIDEO_THS7303 is not set
CONFIG_VIDEO_M52790=m
# CONFIG_VIDEO_I2C is not set
# end of I2C Encoders, decoders, sensors and other helper chips

#
# SPI helper chips
#
# end of SPI helper chips

#
# Media SPI Adapters
#
# CONFIG_CXD2880_SPI_DRV is not set
# end of Media SPI Adapters

CONFIG_MEDIA_TUNER=m

#
# Customize TV tuners
#
CONFIG_MEDIA_TUNER_SIMPLE=m
CONFIG_MEDIA_TUNER_TDA18250=m
CONFIG_MEDIA_TUNER_TDA8290=m
CONFIG_MEDIA_TUNER_TDA827X=m
CONFIG_MEDIA_TUNER_TDA18271=m
CONFIG_MEDIA_TUNER_TDA9887=m
CONFIG_MEDIA_TUNER_TEA5761=m
CONFIG_MEDIA_TUNER_TEA5767=m
# CONFIG_MEDIA_TUNER_MSI001 is not set
CONFIG_MEDIA_TUNER_MT20XX=m
CONFIG_MEDIA_TUNER_MT2060=m
CONFIG_MEDIA_TUNER_MT2063=m
CONFIG_MEDIA_TUNER_MT2266=m
CONFIG_MEDIA_TUNER_MT2131=m
CONFIG_MEDIA_TUNER_QT1010=m
CONFIG_MEDIA_TUNER_XC2028=m
CONFIG_MEDIA_TUNER_XC5000=m
CONFIG_MEDIA_TUNER_XC4000=m
CONFIG_MEDIA_TUNER_MXL5005S=m
CONFIG_MEDIA_TUNER_MXL5007T=m
CONFIG_MEDIA_TUNER_MC44S803=m
CONFIG_MEDIA_TUNER_MAX2165=m
CONFIG_MEDIA_TUNER_TDA18218=m
CONFIG_MEDIA_TUNER_FC0011=m
CONFIG_MEDIA_TUNER_FC0012=m
CONFIG_MEDIA_TUNER_FC0013=m
CONFIG_MEDIA_TUNER_TDA18212=m
CONFIG_MEDIA_TUNER_E4000=m
CONFIG_MEDIA_TUNER_FC2580=m
CONFIG_MEDIA_TUNER_M88RS6000T=m
CONFIG_MEDIA_TUNER_TUA9001=m
CONFIG_MEDIA_TUNER_SI2157=m
CONFIG_MEDIA_TUNER_IT913X=m
CONFIG_MEDIA_TUNER_R820T=m
# CONFIG_MEDIA_TUNER_MXL301RF is not set
CONFIG_MEDIA_TUNER_QM1D1C0042=m
CONFIG_MEDIA_TUNER_QM1D1B0004=m
# end of Customize TV tuners

#
# Customise DVB Frontends
#

#
# Multistandard (satellite) frontends
#
CONFIG_DVB_STB0899=m
CONFIG_DVB_STB6100=m
CONFIG_DVB_STV090x=m
CONFIG_DVB_STV0910=m
CONFIG_DVB_STV6110x=m
CONFIG_DVB_STV6111=m
CONFIG_DVB_MXL5XX=m
CONFIG_DVB_M88DS3103=m

#
# Multistandard (cable + terrestrial) frontends
#
CONFIG_DVB_DRXK=m
CONFIG_DVB_TDA18271C2DD=m
CONFIG_DVB_SI2165=m
CONFIG_DVB_MN88472=m
CONFIG_DVB_MN88473=m

#
# DVB-S (satellite) frontends
#
CONFIG_DVB_CX24110=m
CONFIG_DVB_CX24123=m
CONFIG_DVB_MT312=m
CONFIG_DVB_ZL10036=m
CONFIG_DVB_ZL10039=m
CONFIG_DVB_S5H1420=m
CONFIG_DVB_STV0288=m
CONFIG_DVB_STB6000=m
CONFIG_DVB_STV0299=m
CONFIG_DVB_STV6110=m
CONFIG_DVB_STV0900=m
CONFIG_DVB_TDA8083=m
CONFIG_DVB_TDA10086=m
CONFIG_DVB_TDA8261=m
CONFIG_DVB_VES1X93=m
CONFIG_DVB_TUNER_ITD1000=m
CONFIG_DVB_TUNER_CX24113=m
CONFIG_DVB_TDA826X=m
CONFIG_DVB_TUA6100=m
CONFIG_DVB_CX24116=m
CONFIG_DVB_CX24117=m
CONFIG_DVB_CX24120=m
CONFIG_DVB_SI21XX=m
CONFIG_DVB_TS2020=m
CONFIG_DVB_DS3000=m
CONFIG_DVB_MB86A16=m
CONFIG_DVB_TDA10071=m

#
# DVB-T (terrestrial) frontends
#
CONFIG_DVB_SP8870=m
CONFIG_DVB_SP887X=m
CONFIG_DVB_CX22700=m
CONFIG_DVB_CX22702=m
# CONFIG_DVB_S5H1432 is not set
CONFIG_DVB_DRXD=m
CONFIG_DVB_L64781=m
CONFIG_DVB_TDA1004X=m
CONFIG_DVB_NXT6000=m
CONFIG_DVB_MT352=m
CONFIG_DVB_ZL10353=m
CONFIG_DVB_DIB3000MB=m
CONFIG_DVB_DIB3000MC=m
CONFIG_DVB_DIB7000M=m
CONFIG_DVB_DIB7000P=m
# CONFIG_DVB_DIB9000 is not set
CONFIG_DVB_TDA10048=m
CONFIG_DVB_AF9013=m
CONFIG_DVB_EC100=m
CONFIG_DVB_STV0367=m
CONFIG_DVB_CXD2820R=m
CONFIG_DVB_CXD2841ER=m
CONFIG_DVB_RTL2830=m
CONFIG_DVB_RTL2832=m
CONFIG_DVB_SI2168=m
# CONFIG_DVB_ZD1301_DEMOD is not set
CONFIG_DVB_GP8PSK_FE=m
# CONFIG_DVB_CXD2880 is not set

#
# DVB-C (cable) frontends
#
CONFIG_DVB_VES1820=m
CONFIG_DVB_TDA10021=m
CONFIG_DVB_TDA10023=m
CONFIG_DVB_STV0297=m

#
# ATSC (North American/Korean Terrestrial/Cable DTV) frontends
#
CONFIG_DVB_NXT200X=m
CONFIG_DVB_OR51211=m
CONFIG_DVB_OR51132=m
CONFIG_DVB_BCM3510=m
CONFIG_DVB_LGDT330X=m
CONFIG_DVB_LGDT3305=m
CONFIG_DVB_LGDT3306A=m
CONFIG_DVB_LG2160=m
CONFIG_DVB_S5H1409=m
CONFIG_DVB_AU8522=m
CONFIG_DVB_AU8522_DTV=m
CONFIG_DVB_AU8522_V4L=m
CONFIG_DVB_S5H1411=m

#
# ISDB-T (terrestrial) frontends
#
CONFIG_DVB_S921=m
CONFIG_DVB_DIB8000=m
CONFIG_DVB_MB86A20S=m

#
# ISDB-S (satellite) & ISDB-T (terrestrial) frontends
#
CONFIG_DVB_TC90522=m
# CONFIG_DVB_MN88443X is not set

#
# Digital terrestrial only tuners/PLL
#
CONFIG_DVB_PLL=m
CONFIG_DVB_TUNER_DIB0070=m
CONFIG_DVB_TUNER_DIB0090=m

#
# SEC control devices for DVB-S
#
CONFIG_DVB_DRX39XYJ=m
CONFIG_DVB_LNBH25=m
# CONFIG_DVB_LNBH29 is not set
CONFIG_DVB_LNBP21=m
CONFIG_DVB_LNBP22=m
CONFIG_DVB_ISL6405=m
CONFIG_DVB_ISL6421=m
CONFIG_DVB_ISL6423=m
CONFIG_DVB_A8293=m
# CONFIG_DVB_LGS8GL5 is not set
CONFIG_DVB_LGS8GXX=m
CONFIG_DVB_ATBM8830=m
CONFIG_DVB_TDA665x=m
CONFIG_DVB_IX2505V=m
CONFIG_DVB_M88RS2000=m
CONFIG_DVB_AF9033=m
# CONFIG_DVB_HORUS3A is not set
# CONFIG_DVB_ASCOT2E is not set
# CONFIG_DVB_HELENE is not set

#
# Common Interface (EN50221) controller drivers
#
CONFIG_DVB_CXD2099=m
# CONFIG_DVB_SP2 is not set

#
# Tools to develop new frontends
#
CONFIG_DVB_DUMMY_FE=m
# end of Customise DVB Frontends

#
# Graphics support
#
CONFIG_AGP=y
CONFIG_AGP_AMD64=y
CONFIG_AGP_INTEL=y
CONFIG_AGP_SIS=y
CONFIG_AGP_VIA=y
CONFIG_INTEL_GTT=y
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=64
CONFIG_VGA_SWITCHEROO=y
CONFIG_DRM=m
CONFIG_DRM_MIPI_DSI=y
CONFIG_DRM_DP_AUX_CHARDEV=y
CONFIG_DRM_DEBUG_SELFTEST=m
CONFIG_DRM_KMS_HELPER=m
CONFIG_DRM_KMS_FB_HELPER=y
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
# CONFIG_DRM_FBDEV_LEAK_PHYS_SMEM is not set
CONFIG_DRM_LOAD_EDID_FIRMWARE=y
# CONFIG_DRM_DP_CEC is not set
CONFIG_DRM_TTM=m
CONFIG_DRM_VRAM_HELPER=m
CONFIG_DRM_GEM_SHMEM_HELPER=y

#
# I2C encoder or helper chips
#
CONFIG_DRM_I2C_CH7006=m
CONFIG_DRM_I2C_SIL164=m
# CONFIG_DRM_I2C_NXP_TDA998X is not set
# CONFIG_DRM_I2C_NXP_TDA9950 is not set
# end of I2C encoder or helper chips

#
# ARM devices
#
# end of ARM devices

# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_AMDGPU is not set

#
# ACP (Audio CoProcessor) Configuration
#
# end of ACP (Audio CoProcessor) Configuration

# CONFIG_DRM_NOUVEAU is not set
CONFIG_DRM_I915=m
# CONFIG_DRM_I915_ALPHA_SUPPORT is not set
CONFIG_DRM_I915_FORCE_PROBE=""
CONFIG_DRM_I915_CAPTURE_ERROR=y
CONFIG_DRM_I915_COMPRESS_ERROR=y
CONFIG_DRM_I915_USERPTR=y
CONFIG_DRM_I915_GVT=y
CONFIG_DRM_I915_GVT_KVMGT=m

#
# drm/i915 Debugging
#
# CONFIG_DRM_I915_WERROR is not set
# CONFIG_DRM_I915_DEBUG is not set
# CONFIG_DRM_I915_DEBUG_MMIO is not set
# CONFIG_DRM_I915_SW_FENCE_DEBUG_OBJECTS is not set
# CONFIG_DRM_I915_SW_FENCE_CHECK_DAG is not set
# CONFIG_DRM_I915_DEBUG_GUC is not set
# CONFIG_DRM_I915_SELFTEST is not set
# CONFIG_DRM_I915_LOW_LEVEL_TRACEPOINTS is not set
# CONFIG_DRM_I915_DEBUG_VBLANK_EVADE is not set
# CONFIG_DRM_I915_DEBUG_RUNTIME_PM is not set
# end of drm/i915 Debugging

#
# drm/i915 Profile Guided Optimisation
#
CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND=250
CONFIG_DRM_I915_SPIN_REQUEST=5
# end of drm/i915 Profile Guided Optimisation

CONFIG_DRM_VGEM=m
# CONFIG_DRM_VKMS is not set
CONFIG_DRM_VMWGFX=m
CONFIG_DRM_VMWGFX_FBCON=y
CONFIG_DRM_GMA500=m
CONFIG_DRM_GMA600=y
CONFIG_DRM_GMA3600=y
CONFIG_DRM_UDL=m
CONFIG_DRM_AST=m
CONFIG_DRM_MGAG200=m
CONFIG_DRM_CIRRUS_QEMU=m
CONFIG_DRM_QXL=m
CONFIG_DRM_BOCHS=m
CONFIG_DRM_VIRTIO_GPU=m
CONFIG_DRM_PANEL=y

#
# Display Panels
#
# CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN is not set
# end of Display Panels

CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
# CONFIG_DRM_ANALOGIX_ANX78XX is not set
# end of Display Interface Bridges

# CONFIG_DRM_ETNAVIV is not set
# CONFIG_DRM_GM12U320 is not set
# CONFIG_TINYDRM_HX8357D is not set
# CONFIG_TINYDRM_ILI9225 is not set
# CONFIG_TINYDRM_ILI9341 is not set
# CONFIG_TINYDRM_MI0283QT is not set
# CONFIG_TINYDRM_REPAPER is not set
# CONFIG_TINYDRM_ST7586 is not set
# CONFIG_TINYDRM_ST7735R is not set
# CONFIG_DRM_XEN is not set
# CONFIG_DRM_VBOXVIDEO is not set
# CONFIG_DRM_LEGACY is not set
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y
CONFIG_DRM_LIB_RANDOM=y

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB=y
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_BOOT_VESA_SUPPORT=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=m
CONFIG_FB_SYS_COPYAREA=m
CONFIG_FB_SYS_IMAGEBLIT=m
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=m
CONFIG_FB_DEFERRED_IO=y
# CONFIG_FB_MODE_HELPERS is not set
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_UVESA is not set
CONFIG_FB_VESA=y
CONFIG_FB_EFI=y
# CONFIG_FB_N411 is not set
# CONFIG_FB_HGA is not set
# CONFIG_FB_OPENCORES is not set
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I740 is not set
# CONFIG_FB_LE80578 is not set
# CONFIG_FB_INTEL is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_S3 is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_VIA is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_VT8623 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_ARK is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CARMINE is not set
# CONFIG_FB_SM501 is not set
# CONFIG_FB_SMSCUFX is not set
# CONFIG_FB_UDL is not set
# CONFIG_FB_IBM_GXT4500 is not set
# CONFIG_FB_VIRTUAL is not set
# CONFIG_XEN_FBDEV_FRONTEND is not set
# CONFIG_FB_METRONOME is not set
# CONFIG_FB_MB862XX is not set
CONFIG_FB_HYPERV=m
# CONFIG_FB_SIMPLE is not set
# CONFIG_FB_SM712 is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=m
# CONFIG_LCD_L4F00242T03 is not set
# CONFIG_LCD_LMS283GF05 is not set
# CONFIG_LCD_LTV350QV is not set
# CONFIG_LCD_ILI922X is not set
# CONFIG_LCD_ILI9320 is not set
# CONFIG_LCD_TDO24M is not set
# CONFIG_LCD_VGG2432A4 is not set
CONFIG_LCD_PLATFORM=m
# CONFIG_LCD_AMS369FG06 is not set
# CONFIG_LCD_LMS501KF03 is not set
# CONFIG_LCD_HX8357 is not set
# CONFIG_LCD_OTM3225A is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
# CONFIG_BACKLIGHT_GENERIC is not set
# CONFIG_BACKLIGHT_PWM is not set
CONFIG_BACKLIGHT_APPLE=m
# CONFIG_BACKLIGHT_PM8941_WLED is not set
# CONFIG_BACKLIGHT_SAHARA is not set
# CONFIG_BACKLIGHT_ADP8860 is not set
# CONFIG_BACKLIGHT_ADP8870 is not set
# CONFIG_BACKLIGHT_LM3630A is not set
# CONFIG_BACKLIGHT_LM3639 is not set
CONFIG_BACKLIGHT_LP855X=m
# CONFIG_BACKLIGHT_GPIO is not set
# CONFIG_BACKLIGHT_LV5207LP is not set
# CONFIG_BACKLIGHT_BD6107 is not set
# CONFIG_BACKLIGHT_ARCXCNN is not set
# end of Backlight & LCD device support

CONFIG_HDMI=y

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_VGACON_SOFT_SCROLLBACK=y
CONFIG_VGACON_SOFT_SCROLLBACK_SIZE=64
# CONFIG_VGACON_SOFT_SCROLLBACK_PERSISTENT_ENABLE_BY_DEFAULT is not set
CONFIG_DUMMY_CONSOLE=y
CONFIG_DUMMY_CONSOLE_COLUMNS=80
CONFIG_DUMMY_CONSOLE_ROWS=25
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
# CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER is not set
# end of Console display driver support

CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
# CONFIG_LOGO_LINUX_VGA16 is not set
CONFIG_LOGO_LINUX_CLUT224=y
# end of Graphics support

CONFIG_SOUND=m
CONFIG_SOUND_OSS_CORE=y
CONFIG_SOUND_OSS_CORE_PRECLAIM=y
CONFIG_SND=m
CONFIG_SND_TIMER=m
CONFIG_SND_PCM=m
CONFIG_SND_PCM_ELD=y
CONFIG_SND_HWDEP=m
CONFIG_SND_SEQ_DEVICE=m
CONFIG_SND_RAWMIDI=m
CONFIG_SND_COMPRESS_OFFLOAD=m
CONFIG_SND_JACK=y
CONFIG_SND_JACK_INPUT_DEV=y
CONFIG_SND_OSSEMUL=y
# CONFIG_SND_MIXER_OSS is not set
# CONFIG_SND_PCM_OSS is not set
CONFIG_SND_PCM_TIMER=y
CONFIG_SND_HRTIMER=m
CONFIG_SND_DYNAMIC_MINORS=y
CONFIG_SND_MAX_CARDS=32
# CONFIG_SND_SUPPORT_OLD_API is not set
CONFIG_SND_PROC_FS=y
CONFIG_SND_VERBOSE_PROCFS=y
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set
CONFIG_SND_VMASTER=y
CONFIG_SND_DMA_SGBUF=y
CONFIG_SND_SEQUENCER=m
CONFIG_SND_SEQ_DUMMY=m
CONFIG_SND_SEQUENCER_OSS=m
CONFIG_SND_SEQ_HRTIMER_DEFAULT=y
CONFIG_SND_SEQ_MIDI_EVENT=m
CONFIG_SND_SEQ_MIDI=m
CONFIG_SND_SEQ_MIDI_EMUL=m
CONFIG_SND_SEQ_VIRMIDI=m
CONFIG_SND_MPU401_UART=m
CONFIG_SND_OPL3_LIB=m
CONFIG_SND_OPL3_LIB_SEQ=m
CONFIG_SND_VX_LIB=m
CONFIG_SND_AC97_CODEC=m
CONFIG_SND_DRIVERS=y
CONFIG_SND_PCSP=m
CONFIG_SND_DUMMY=m
CONFIG_SND_ALOOP=m
CONFIG_SND_VIRMIDI=m
CONFIG_SND_MTPAV=m
# CONFIG_SND_MTS64 is not set
# CONFIG_SND_SERIAL_U16550 is not set
CONFIG_SND_MPU401=m
# CONFIG_SND_PORTMAN2X4 is not set
CONFIG_SND_AC97_POWER_SAVE=y
CONFIG_SND_AC97_POWER_SAVE_DEFAULT=5
CONFIG_SND_PCI=y
CONFIG_SND_AD1889=m
# CONFIG_SND_ALS300 is not set
# CONFIG_SND_ALS4000 is not set
CONFIG_SND_ALI5451=m
CONFIG_SND_ASIHPI=m
CONFIG_SND_ATIIXP=m
CONFIG_SND_ATIIXP_MODEM=m
CONFIG_SND_AU8810=m
CONFIG_SND_AU8820=m
CONFIG_SND_AU8830=m
# CONFIG_SND_AW2 is not set
# CONFIG_SND_AZT3328 is not set
CONFIG_SND_BT87X=m
# CONFIG_SND_BT87X_OVERCLOCK is not set
CONFIG_SND_CA0106=m
CONFIG_SND_CMIPCI=m
CONFIG_SND_OXYGEN_LIB=m
CONFIG_SND_OXYGEN=m
# CONFIG_SND_CS4281 is not set
CONFIG_SND_CS46XX=m
CONFIG_SND_CS46XX_NEW_DSP=y
CONFIG_SND_CTXFI=m
CONFIG_SND_DARLA20=m
CONFIG_SND_GINA20=m
CONFIG_SND_LAYLA20=m
CONFIG_SND_DARLA24=m
CONFIG_SND_GINA24=m
CONFIG_SND_LAYLA24=m
CONFIG_SND_MONA=m
CONFIG_SND_MIA=m
CONFIG_SND_ECHO3G=m
CONFIG_SND_INDIGO=m
CONFIG_SND_INDIGOIO=m
CONFIG_SND_INDIGODJ=m
CONFIG_SND_INDIGOIOX=m
CONFIG_SND_INDIGODJX=m
CONFIG_SND_EMU10K1=m
CONFIG_SND_EMU10K1_SEQ=m
CONFIG_SND_EMU10K1X=m
CONFIG_SND_ENS1370=m
CONFIG_SND_ENS1371=m
# CONFIG_SND_ES1938 is not set
CONFIG_SND_ES1968=m
CONFIG_SND_ES1968_INPUT=y
CONFIG_SND_ES1968_RADIO=y
# CONFIG_SND_FM801 is not set
CONFIG_SND_HDSP=m
CONFIG_SND_HDSPM=m
CONFIG_SND_ICE1712=m
CONFIG_SND_ICE1724=m
CONFIG_SND_INTEL8X0=m
CONFIG_SND_INTEL8X0M=m
CONFIG_SND_KORG1212=m
CONFIG_SND_LOLA=m
CONFIG_SND_LX6464ES=m
CONFIG_SND_MAESTRO3=m
CONFIG_SND_MAESTRO3_INPUT=y
CONFIG_SND_MIXART=m
# CONFIG_SND_NM256 is not set
CONFIG_SND_PCXHR=m
# CONFIG_SND_RIPTIDE is not set
CONFIG_SND_RME32=m
CONFIG_SND_RME96=m
CONFIG_SND_RME9652=m
# CONFIG_SND_SONICVIBES is not set
CONFIG_SND_TRIDENT=m
CONFIG_SND_VIA82XX=m
CONFIG_SND_VIA82XX_MODEM=m
CONFIG_SND_VIRTUOSO=m
CONFIG_SND_VX222=m
# CONFIG_SND_YMFPCI is not set

#
# HD-Audio
#
CONFIG_SND_HDA=m
CONFIG_SND_HDA_INTEL=m
# CONFIG_SND_HDA_INTEL_DETECT_DMIC is not set
CONFIG_SND_HDA_HWDEP=y
CONFIG_SND_HDA_RECONFIG=y
CONFIG_SND_HDA_INPUT_BEEP=y
CONFIG_SND_HDA_INPUT_BEEP_MODE=0
CONFIG_SND_HDA_PATCH_LOADER=y
CONFIG_SND_HDA_CODEC_REALTEK=m
CONFIG_SND_HDA_CODEC_ANALOG=m
CONFIG_SND_HDA_CODEC_SIGMATEL=m
CONFIG_SND_HDA_CODEC_VIA=m
CONFIG_SND_HDA_CODEC_HDMI=m
CONFIG_SND_HDA_CODEC_CIRRUS=m
CONFIG_SND_HDA_CODEC_CONEXANT=m
CONFIG_SND_HDA_CODEC_CA0110=m
CONFIG_SND_HDA_CODEC_CA0132=m
CONFIG_SND_HDA_CODEC_CA0132_DSP=y
CONFIG_SND_HDA_CODEC_CMEDIA=m
CONFIG_SND_HDA_CODEC_SI3054=m
CONFIG_SND_HDA_GENERIC=m
CONFIG_SND_HDA_POWER_SAVE_DEFAULT=0
# end of HD-Audio

CONFIG_SND_HDA_CORE=m
CONFIG_SND_HDA_DSP_LOADER=y
CONFIG_SND_HDA_COMPONENT=y
CONFIG_SND_HDA_I915=y
CONFIG_SND_HDA_EXT_CORE=m
CONFIG_SND_HDA_PREALLOC_SIZE=512
CONFIG_SND_INTEL_NHLT=m
# CONFIG_SND_SPI is not set
CONFIG_SND_USB=y
CONFIG_SND_USB_AUDIO=m
CONFIG_SND_USB_AUDIO_USE_MEDIA_CONTROLLER=y
CONFIG_SND_USB_UA101=m
CONFIG_SND_USB_USX2Y=m
CONFIG_SND_USB_CAIAQ=m
CONFIG_SND_USB_CAIAQ_INPUT=y
CONFIG_SND_USB_US122L=m
CONFIG_SND_USB_6FIRE=m
CONFIG_SND_USB_HIFACE=m
CONFIG_SND_BCD2000=m
CONFIG_SND_USB_LINE6=m
CONFIG_SND_USB_POD=m
CONFIG_SND_USB_PODHD=m
CONFIG_SND_USB_TONEPORT=m
CONFIG_SND_USB_VARIAX=m
CONFIG_SND_FIREWIRE=y
CONFIG_SND_FIREWIRE_LIB=m
# CONFIG_SND_DICE is not set
# CONFIG_SND_OXFW is not set
CONFIG_SND_ISIGHT=m
# CONFIG_SND_FIREWORKS is not set
# CONFIG_SND_BEBOB is not set
# CONFIG_SND_FIREWIRE_DIGI00X is not set
# CONFIG_SND_FIREWIRE_TASCAM is not set
# CONFIG_SND_FIREWIRE_MOTU is not set
# CONFIG_SND_FIREFACE is not set
CONFIG_SND_SOC=m
CONFIG_SND_SOC_COMPRESS=y
CONFIG_SND_SOC_TOPOLOGY=y
CONFIG_SND_SOC_ACPI=m
# CONFIG_SND_SOC_AMD_ACP is not set
# CONFIG_SND_SOC_AMD_ACP3x is not set
# CONFIG_SND_ATMEL_SOC is not set
# CONFIG_SND_DESIGNWARE_I2S is not set

#
# SoC Audio for Freescale CPUs
#

#
# Common SoC Audio options for Freescale CPUs:
#
# CONFIG_SND_SOC_FSL_ASRC is not set
# CONFIG_SND_SOC_FSL_SAI is not set
# CONFIG_SND_SOC_FSL_AUDMIX is not set
# CONFIG_SND_SOC_FSL_SSI is not set
# CONFIG_SND_SOC_FSL_SPDIF is not set
# CONFIG_SND_SOC_FSL_ESAI is not set
# CONFIG_SND_SOC_FSL_MICFIL is not set
# CONFIG_SND_SOC_IMX_AUDMUX is not set
# end of SoC Audio for Freescale CPUs

# CONFIG_SND_I2S_HI6210_I2S is not set
# CONFIG_SND_SOC_IMG is not set
CONFIG_SND_SOC_INTEL_SST_TOPLEVEL=y
CONFIG_SND_SST_IPC=m
CONFIG_SND_SST_IPC_ACPI=m
CONFIG_SND_SOC_INTEL_SST_ACPI=m
CONFIG_SND_SOC_INTEL_SST=m
CONFIG_SND_SOC_INTEL_SST_FIRMWARE=m
CONFIG_SND_SOC_INTEL_HASWELL=m
CONFIG_SND_SST_ATOM_HIFI2_PLATFORM=m
# CONFIG_SND_SST_ATOM_HIFI2_PLATFORM_PCI is not set
CONFIG_SND_SST_ATOM_HIFI2_PLATFORM_ACPI=m
CONFIG_SND_SOC_INTEL_SKYLAKE=m
CONFIG_SND_SOC_INTEL_SKL=m
CONFIG_SND_SOC_INTEL_APL=m
CONFIG_SND_SOC_INTEL_KBL=m
CONFIG_SND_SOC_INTEL_GLK=m
CONFIG_SND_SOC_INTEL_CNL=m
CONFIG_SND_SOC_INTEL_CFL=m
# CONFIG_SND_SOC_INTEL_CML_H is not set
# CONFIG_SND_SOC_INTEL_CML_LP is not set
CONFIG_SND_SOC_INTEL_SKYLAKE_FAMILY=m
CONFIG_SND_SOC_INTEL_SKYLAKE_SSP_CLK=m
# CONFIG_SND_SOC_INTEL_SKYLAKE_HDAUDIO_CODEC is not set
CONFIG_SND_SOC_INTEL_SKYLAKE_COMMON=m
CONFIG_SND_SOC_ACPI_INTEL_MATCH=m
CONFIG_SND_SOC_INTEL_MACH=y
CONFIG_SND_SOC_INTEL_HASWELL_MACH=m
CONFIG_SND_SOC_INTEL_BDW_RT5677_MACH=m
CONFIG_SND_SOC_INTEL_BROADWELL_MACH=m
CONFIG_SND_SOC_INTEL_BYTCR_RT5640_MACH=m
CONFIG_SND_SOC_INTEL_BYTCR_RT5651_MACH=m
CONFIG_SND_SOC_INTEL_CHT_BSW_RT5672_MACH=m
CONFIG_SND_SOC_INTEL_CHT_BSW_RT5645_MACH=m
CONFIG_SND_SOC_INTEL_CHT_BSW_MAX98090_TI_MACH=m
# CONFIG_SND_SOC_INTEL_CHT_BSW_NAU8824_MACH is not set
# CONFIG_SND_SOC_INTEL_BYT_CHT_CX2072X_MACH is not set
CONFIG_SND_SOC_INTEL_BYT_CHT_DA7213_MACH=m
CONFIG_SND_SOC_INTEL_BYT_CHT_ES8316_MACH=m
CONFIG_SND_SOC_INTEL_BYT_CHT_NOCODEC_MACH=m
CONFIG_SND_SOC_INTEL_SKL_RT286_MACH=m
CONFIG_SND_SOC_INTEL_SKL_NAU88L25_SSM4567_MACH=m
CONFIG_SND_SOC_INTEL_SKL_NAU88L25_MAX98357A_MACH=m
CONFIG_SND_SOC_INTEL_DA7219_MAX98357A_GENERIC=m
CONFIG_SND_SOC_INTEL_BXT_DA7219_MAX98357A_MACH=m
CONFIG_SND_SOC_INTEL_BXT_RT298_MACH=m
CONFIG_SND_SOC_INTEL_KBL_RT5663_MAX98927_MACH=m
CONFIG_SND_SOC_INTEL_KBL_RT5663_RT5514_MAX98927_MACH=m
# CONFIG_SND_SOC_INTEL_KBL_DA7219_MAX98357A_MACH is not set
# CONFIG_SND_SOC_INTEL_KBL_DA7219_MAX98927_MACH is not set
# CONFIG_SND_SOC_INTEL_KBL_RT5660_MACH is not set
# CONFIG_SND_SOC_INTEL_GLK_RT5682_MAX98357A_MACH is not set
# CONFIG_SND_SOC_MTK_BTCVSD is not set
# CONFIG_SND_SOC_SOF_TOPLEVEL is not set

#
# STMicroelectronics STM32 SOC audio support
#
# end of STMicroelectronics STM32 SOC audio support

# CONFIG_SND_SOC_XILINX_I2S is not set
# CONFIG_SND_SOC_XILINX_AUDIO_FORMATTER is not set
# CONFIG_SND_SOC_XILINX_SPDIF is not set
# CONFIG_SND_SOC_XTFPGA_I2S is not set
# CONFIG_ZX_TDM is not set
CONFIG_SND_SOC_I2C_AND_SPI=m

#
# CODEC drivers
#
# CONFIG_SND_SOC_AC97_CODEC is not set
# CONFIG_SND_SOC_ADAU1701 is not set
# CONFIG_SND_SOC_ADAU1761_I2C is not set
# CONFIG_SND_SOC_ADAU1761_SPI is not set
# CONFIG_SND_SOC_ADAU7002 is not set
# CONFIG_SND_SOC_AK4104 is not set
# CONFIG_SND_SOC_AK4118 is not set
# CONFIG_SND_SOC_AK4458 is not set
# CONFIG_SND_SOC_AK4554 is not set
# CONFIG_SND_SOC_AK4613 is not set
# CONFIG_SND_SOC_AK4642 is not set
# CONFIG_SND_SOC_AK5386 is not set
# CONFIG_SND_SOC_AK5558 is not set
# CONFIG_SND_SOC_ALC5623 is not set
# CONFIG_SND_SOC_BD28623 is not set
# CONFIG_SND_SOC_BT_SCO is not set
# CONFIG_SND_SOC_CS35L32 is not set
# CONFIG_SND_SOC_CS35L33 is not set
# CONFIG_SND_SOC_CS35L34 is not set
# CONFIG_SND_SOC_CS35L35 is not set
# CONFIG_SND_SOC_CS35L36 is not set
# CONFIG_SND_SOC_CS42L42 is not set
# CONFIG_SND_SOC_CS42L51_I2C is not set
# CONFIG_SND_SOC_CS42L52 is not set
# CONFIG_SND_SOC_CS42L56 is not set
# CONFIG_SND_SOC_CS42L73 is not set
# CONFIG_SND_SOC_CS4265 is not set
# CONFIG_SND_SOC_CS4270 is not set
# CONFIG_SND_SOC_CS4271_I2C is not set
# CONFIG_SND_SOC_CS4271_SPI is not set
# CONFIG_SND_SOC_CS42XX8_I2C is not set
# CONFIG_SND_SOC_CS43130 is not set
# CONFIG_SND_SOC_CS4341 is not set
# CONFIG_SND_SOC_CS4349 is not set
# CONFIG_SND_SOC_CS53L30 is not set
# CONFIG_SND_SOC_CX2072X is not set
CONFIG_SND_SOC_DA7213=m
CONFIG_SND_SOC_DA7219=m
CONFIG_SND_SOC_DMIC=m
# CONFIG_SND_SOC_ES7134 is not set
# CONFIG_SND_SOC_ES7241 is not set
CONFIG_SND_SOC_ES8316=m
# CONFIG_SND_SOC_ES8328_I2C is not set
# CONFIG_SND_SOC_ES8328_SPI is not set
# CONFIG_SND_SOC_GTM601 is not set
CONFIG_SND_SOC_HDAC_HDMI=m
# CONFIG_SND_SOC_INNO_RK3036 is not set
# CONFIG_SND_SOC_MAX98088 is not set
CONFIG_SND_SOC_MAX98090=m
CONFIG_SND_SOC_MAX98357A=m
# CONFIG_SND_SOC_MAX98504 is not set
# CONFIG_SND_SOC_MAX9867 is not set
CONFIG_SND_SOC_MAX98927=m
# CONFIG_SND_SOC_MAX98373 is not set
# CONFIG_SND_SOC_MAX9860 is not set
# CONFIG_SND_SOC_MSM8916_WCD_DIGITAL is not set
# CONFIG_SND_SOC_PCM1681 is not set
# CONFIG_SND_SOC_PCM1789_I2C is not set
# CONFIG_SND_SOC_PCM179X_I2C is not set
# CONFIG_SND_SOC_PCM179X_SPI is not set
# CONFIG_SND_SOC_PCM186X_I2C is not set
# CONFIG_SND_SOC_PCM186X_SPI is not set
# CONFIG_SND_SOC_PCM3060_I2C is not set
# CONFIG_SND_SOC_PCM3060_SPI is not set
# CONFIG_SND_SOC_PCM3168A_I2C is not set
# CONFIG_SND_SOC_PCM3168A_SPI is not set
# CONFIG_SND_SOC_PCM512x_I2C is not set
# CONFIG_SND_SOC_PCM512x_SPI is not set
# CONFIG_SND_SOC_RK3328 is not set
CONFIG_SND_SOC_RL6231=m
CONFIG_SND_SOC_RL6347A=m
CONFIG_SND_SOC_RT286=m
CONFIG_SND_SOC_RT298=m
CONFIG_SND_SOC_RT5514=m
CONFIG_SND_SOC_RT5514_SPI=m
# CONFIG_SND_SOC_RT5616 is not set
# CONFIG_SND_SOC_RT5631 is not set
CONFIG_SND_SOC_RT5640=m
CONFIG_SND_SOC_RT5645=m
CONFIG_SND_SOC_RT5651=m
CONFIG_SND_SOC_RT5663=m
CONFIG_SND_SOC_RT5670=m
CONFIG_SND_SOC_RT5677=m
CONFIG_SND_SOC_RT5677_SPI=m
# CONFIG_SND_SOC_SGTL5000 is not set
# CONFIG_SND_SOC_SIMPLE_AMPLIFIER is not set
# CONFIG_SND_SOC_SIRF_AUDIO_CODEC is not set
# CONFIG_SND_SOC_SPDIF is not set
# CONFIG_SND_SOC_SSM2305 is not set
# CONFIG_SND_SOC_SSM2602_SPI is not set
# CONFIG_SND_SOC_SSM2602_I2C is not set
CONFIG_SND_SOC_SSM4567=m
# CONFIG_SND_SOC_STA32X is not set
# CONFIG_SND_SOC_STA350 is not set
# CONFIG_SND_SOC_STI_SAS is not set
# CONFIG_SND_SOC_TAS2552 is not set
# CONFIG_SND_SOC_TAS5086 is not set
# CONFIG_SND_SOC_TAS571X is not set
# CONFIG_SND_SOC_TAS5720 is not set
# CONFIG_SND_SOC_TAS6424 is not set
# CONFIG_SND_SOC_TDA7419 is not set
# CONFIG_SND_SOC_TFA9879 is not set
# CONFIG_SND_SOC_TLV320AIC23_I2C is not set
# CONFIG_SND_SOC_TLV320AIC23_SPI is not set
# CONFIG_SND_SOC_TLV320AIC31XX is not set
# CONFIG_SND_SOC_TLV320AIC32X4_I2C is not set
# CONFIG_SND_SOC_TLV320AIC32X4_SPI is not set
# CONFIG_SND_SOC_TLV320AIC3X is not set
CONFIG_SND_SOC_TS3A227E=m
# CONFIG_SND_SOC_TSCS42XX is not set
# CONFIG_SND_SOC_TSCS454 is not set
# CONFIG_SND_SOC_UDA1334 is not set
# CONFIG_SND_SOC_WM8510 is not set
# CONFIG_SND_SOC_WM8523 is not set
# CONFIG_SND_SOC_WM8524 is not set
# CONFIG_SND_SOC_WM8580 is not set
# CONFIG_SND_SOC_WM8711 is not set
# CONFIG_SND_SOC_WM8728 is not set
# CONFIG_SND_SOC_WM8731 is not set
# CONFIG_SND_SOC_WM8737 is not set
# CONFIG_SND_SOC_WM8741 is not set
# CONFIG_SND_SOC_WM8750 is not set
# CONFIG_SND_SOC_WM8753 is not set
# CONFIG_SND_SOC_WM8770 is not set
# CONFIG_SND_SOC_WM8776 is not set
# CONFIG_SND_SOC_WM8782 is not set
# CONFIG_SND_SOC_WM8804_I2C is not set
# CONFIG_SND_SOC_WM8804_SPI is not set
# CONFIG_SND_SOC_WM8903 is not set
# CONFIG_SND_SOC_WM8904 is not set
# CONFIG_SND_SOC_WM8960 is not set
# CONFIG_SND_SOC_WM8962 is not set
# CONFIG_SND_SOC_WM8974 is not set
# CONFIG_SND_SOC_WM8978 is not set
# CONFIG_SND_SOC_WM8985 is not set
# CONFIG_SND_SOC_ZX_AUD96P22 is not set
# CONFIG_SND_SOC_MAX9759 is not set
# CONFIG_SND_SOC_MT6351 is not set
# CONFIG_SND_SOC_MT6358 is not set
# CONFIG_SND_SOC_NAU8540 is not set
# CONFIG_SND_SOC_NAU8810 is not set
# CONFIG_SND_SOC_NAU8822 is not set
CONFIG_SND_SOC_NAU8824=m
CONFIG_SND_SOC_NAU8825=m
# CONFIG_SND_SOC_TPA6130A2 is not set
# end of CODEC drivers

# CONFIG_SND_SIMPLE_CARD is not set
CONFIG_SND_X86=y
CONFIG_HDMI_LPE_AUDIO=m
CONFIG_SND_SYNTH_EMUX=m
# CONFIG_SND_XEN_FRONTEND is not set
CONFIG_AC97_BUS=m

#
# HID support
#
CONFIG_HID=y
CONFIG_HID_BATTERY_STRENGTH=y
CONFIG_HIDRAW=y
CONFIG_UHID=m
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
CONFIG_HID_A4TECH=y
# CONFIG_HID_ACCUTOUCH is not set
CONFIG_HID_ACRUX=m
# CONFIG_HID_ACRUX_FF is not set
CONFIG_HID_APPLE=y
CONFIG_HID_APPLEIR=m
# CONFIG_HID_ASUS is not set
CONFIG_HID_AUREAL=m
CONFIG_HID_BELKIN=y
# CONFIG_HID_BETOP_FF is not set
# CONFIG_HID_BIGBEN_FF is not set
CONFIG_HID_CHERRY=y
CONFIG_HID_CHICONY=y
# CONFIG_HID_CORSAIR is not set
# CONFIG_HID_COUGAR is not set
# CONFIG_HID_MACALLY is not set
CONFIG_HID_PRODIKEYS=m
# CONFIG_HID_CMEDIA is not set
# CONFIG_HID_CP2112 is not set
# CONFIG_HID_CREATIVE_SB0540 is not set
CONFIG_HID_CYPRESS=y
CONFIG_HID_DRAGONRISE=m
# CONFIG_DRAGONRISE_FF is not set
# CONFIG_HID_EMS_FF is not set
# CONFIG_HID_ELAN is not set
CONFIG_HID_ELECOM=m
# CONFIG_HID_ELO is not set
CONFIG_HID_EZKEY=y
# CONFIG_HID_GEMBIRD is not set
# CONFIG_HID_GFRM is not set
CONFIG_HID_HOLTEK=m
# CONFIG_HOLTEK_FF is not set
# CONFIG_HID_GT683R is not set
CONFIG_HID_KEYTOUCH=m
CONFIG_HID_KYE=m
CONFIG_HID_UCLOGIC=m
CONFIG_HID_WALTOP=m
# CONFIG_HID_VIEWSONIC is not set
CONFIG_HID_GYRATION=m
CONFIG_HID_ICADE=m
CONFIG_HID_ITE=y
# CONFIG_HID_JABRA is not set
CONFIG_HID_TWINHAN=m
CONFIG_HID_KENSINGTON=y
CONFIG_HID_LCPOWER=m
CONFIG_HID_LED=m
# CONFIG_HID_LENOVO is not set
CONFIG_HID_LOGITECH=y
CONFIG_HID_LOGITECH_DJ=m
CONFIG_HID_LOGITECH_HIDPP=m
# CONFIG_LOGITECH_FF is not set
# CONFIG_LOGIRUMBLEPAD2_FF is not set
# CONFIG_LOGIG940_FF is not set
# CONFIG_LOGIWHEELS_FF is not set
CONFIG_HID_MAGICMOUSE=y
# CONFIG_HID_MALTRON is not set
# CONFIG_HID_MAYFLASH is not set
CONFIG_HID_REDRAGON=y
CONFIG_HID_MICROSOFT=y
CONFIG_HID_MONTEREY=y
CONFIG_HID_MULTITOUCH=m
# CONFIG_HID_NTI is not set
CONFIG_HID_NTRIG=y
CONFIG_HID_ORTEK=m
CONFIG_HID_PANTHERLORD=m
# CONFIG_PANTHERLORD_FF is not set
# CONFIG_HID_PENMOUNT is not set
CONFIG_HID_PETALYNX=m
CONFIG_HID_PICOLCD=m
CONFIG_HID_PICOLCD_FB=y
CONFIG_HID_PICOLCD_BACKLIGHT=y
CONFIG_HID_PICOLCD_LCD=y
CONFIG_HID_PICOLCD_LEDS=y
CONFIG_HID_PICOLCD_CIR=y
CONFIG_HID_PLANTRONICS=y
CONFIG_HID_PRIMAX=m
# CONFIG_HID_RETRODE is not set
CONFIG_HID_ROCCAT=m
CONFIG_HID_SAITEK=m
CONFIG_HID_SAMSUNG=m
CONFIG_HID_SONY=m
# CONFIG_SONY_FF is not set
CONFIG_HID_SPEEDLINK=m
# CONFIG_HID_STEAM is not set
CONFIG_HID_STEELSERIES=m
CONFIG_HID_SUNPLUS=m
CONFIG_HID_RMI=m
CONFIG_HID_GREENASIA=m
# CONFIG_GREENASIA_FF is not set
CONFIG_HID_HYPERV_MOUSE=m
CONFIG_HID_SMARTJOYPLUS=m
# CONFIG_SMARTJOYPLUS_FF is not set
CONFIG_HID_TIVO=m
CONFIG_HID_TOPSEED=m
CONFIG_HID_THINGM=m
CONFIG_HID_THRUSTMASTER=m
# CONFIG_THRUSTMASTER_FF is not set
# CONFIG_HID_UDRAW_PS3 is not set
# CONFIG_HID_U2FZERO is not set
CONFIG_HID_WACOM=m
CONFIG_HID_WIIMOTE=m
# CONFIG_HID_XINMO is not set
CONFIG_HID_ZEROPLUS=m
# CONFIG_ZEROPLUS_FF is not set
CONFIG_HID_ZYDACRON=m
CONFIG_HID_SENSOR_HUB=m
CONFIG_HID_SENSOR_CUSTOM_SENSOR=m
CONFIG_HID_ALPS=m
# end of Special HID drivers

#
# USB HID support
#
CONFIG_USB_HID=y
CONFIG_HID_PID=y
CONFIG_USB_HIDDEV=y
# end of USB HID support

#
# I2C HID support
#
CONFIG_I2C_HID=m
# end of I2C HID support

#
# Intel ISH HID support
#
CONFIG_INTEL_ISH_HID=y
# CONFIG_INTEL_ISH_FIRMWARE_DOWNLOADER is not set
# end of Intel ISH HID support
# end of HID support

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
# CONFIG_USB_LED_TRIG is not set
# CONFIG_USB_ULPI_BUS is not set
# CONFIG_USB_CONN_GPIO is not set
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
CONFIG_USB_PCI=y
CONFIG_USB_ANNOUNCE_NEW_DEVICES=y

#
# Miscellaneous USB options
#
CONFIG_USB_DEFAULT_PERSIST=y
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_OTG is not set
# CONFIG_USB_OTG_WHITELIST is not set
# CONFIG_USB_OTG_BLACKLIST_HUB is not set
CONFIG_USB_LEDS_TRIGGER_USBPORT=m
CONFIG_USB_AUTOSUSPEND_DELAY=2
CONFIG_USB_MON=y

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
CONFIG_USB_XHCI_HCD=y
# CONFIG_USB_XHCI_DBGCAP is not set
CONFIG_USB_XHCI_PCI=y
# CONFIG_USB_XHCI_PLATFORM is not set
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
CONFIG_USB_EHCI_TT_NEWSCHED=y
CONFIG_USB_EHCI_PCI=y
# CONFIG_USB_EHCI_FSL is not set
# CONFIG_USB_EHCI_HCD_PLATFORM is not set
# CONFIG_USB_OXU210HP_HCD is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_FOTG210_HCD is not set
# CONFIG_USB_MAX3421_HCD is not set
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_OHCI_HCD_PCI=y
# CONFIG_USB_OHCI_HCD_PLATFORM is not set
CONFIG_USB_UHCI_HCD=y
# CONFIG_USB_U132_HCD is not set
# CONFIG_USB_SL811_HCD is not set
# CONFIG_USB_R8A66597_HCD is not set
# CONFIG_USB_HCD_BCMA is not set
# CONFIG_USB_HCD_SSB is not set
# CONFIG_USB_HCD_TEST_MODE is not set

#
# USB Device Class drivers
#
CONFIG_USB_ACM=m
CONFIG_USB_PRINTER=m
CONFIG_USB_WDM=m
CONFIG_USB_TMC=m

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
CONFIG_USB_STORAGE_REALTEK=m
CONFIG_REALTEK_AUTOPM=y
CONFIG_USB_STORAGE_DATAFAB=m
CONFIG_USB_STORAGE_FREECOM=m
CONFIG_USB_STORAGE_ISD200=m
CONFIG_USB_STORAGE_USBAT=m
CONFIG_USB_STORAGE_SDDR09=m
CONFIG_USB_STORAGE_SDDR55=m
CONFIG_USB_STORAGE_JUMPSHOT=m
CONFIG_USB_STORAGE_ALAUDA=m
CONFIG_USB_STORAGE_ONETOUCH=m
CONFIG_USB_STORAGE_KARMA=m
CONFIG_USB_STORAGE_CYPRESS_ATACB=m
CONFIG_USB_STORAGE_ENE_UB6250=m
CONFIG_USB_UAS=m

#
# USB Imaging devices
#
CONFIG_USB_MDC800=m
CONFIG_USB_MICROTEK=m
CONFIG_USBIP_CORE=m
# CONFIG_USBIP_VHCI_HCD is not set
# CONFIG_USBIP_HOST is not set
# CONFIG_USBIP_DEBUG is not set
# CONFIG_USB_CDNS3 is not set
# CONFIG_USB_MUSB_HDRC is not set
# CONFIG_USB_DWC3 is not set
# CONFIG_USB_DWC2 is not set
# CONFIG_USB_CHIPIDEA is not set
# CONFIG_USB_ISP1760 is not set

#
# USB port drivers
#
CONFIG_USB_USS720=m
CONFIG_USB_SERIAL=y
CONFIG_USB_SERIAL_CONSOLE=y
CONFIG_USB_SERIAL_GENERIC=y
# CONFIG_USB_SERIAL_SIMPLE is not set
CONFIG_USB_SERIAL_AIRCABLE=m
CONFIG_USB_SERIAL_ARK3116=m
CONFIG_USB_SERIAL_BELKIN=m
CONFIG_USB_SERIAL_CH341=m
CONFIG_USB_SERIAL_WHITEHEAT=m
CONFIG_USB_SERIAL_DIGI_ACCELEPORT=m
CONFIG_USB_SERIAL_CP210X=m
CONFIG_USB_SERIAL_CYPRESS_M8=m
CONFIG_USB_SERIAL_EMPEG=m
CONFIG_USB_SERIAL_FTDI_SIO=m
CONFIG_USB_SERIAL_VISOR=m
CONFIG_USB_SERIAL_IPAQ=m
CONFIG_USB_SERIAL_IR=m
CONFIG_USB_SERIAL_EDGEPORT=m
CONFIG_USB_SERIAL_EDGEPORT_TI=m
# CONFIG_USB_SERIAL_F81232 is not set
# CONFIG_USB_SERIAL_F8153X is not set
CONFIG_USB_SERIAL_GARMIN=m
CONFIG_USB_SERIAL_IPW=m
CONFIG_USB_SERIAL_IUU=m
CONFIG_USB_SERIAL_KEYSPAN_PDA=m
CONFIG_USB_SERIAL_KEYSPAN=m
CONFIG_USB_SERIAL_KLSI=m
CONFIG_USB_SERIAL_KOBIL_SCT=m
CONFIG_USB_SERIAL_MCT_U232=m
# CONFIG_USB_SERIAL_METRO is not set
CONFIG_USB_SERIAL_MOS7720=m
CONFIG_USB_SERIAL_MOS7715_PARPORT=y
CONFIG_USB_SERIAL_MOS7840=m
# CONFIG_USB_SERIAL_MXUPORT is not set
CONFIG_USB_SERIAL_NAVMAN=m
CONFIG_USB_SERIAL_PL2303=m
CONFIG_USB_SERIAL_OTI6858=m
CONFIG_USB_SERIAL_QCAUX=m
CONFIG_USB_SERIAL_QUALCOMM=m
CONFIG_USB_SERIAL_SPCP8X5=m
CONFIG_USB_SERIAL_SAFE=m
CONFIG_USB_SERIAL_SAFE_PADDED=y
CONFIG_USB_SERIAL_SIERRAWIRELESS=m
CONFIG_USB_SERIAL_SYMBOL=m
# CONFIG_USB_SERIAL_TI is not set
CONFIG_USB_SERIAL_CYBERJACK=m
CONFIG_USB_SERIAL_XIRCOM=m
CONFIG_USB_SERIAL_WWAN=m
CONFIG_USB_SERIAL_OPTION=m
CONFIG_USB_SERIAL_OMNINET=m
CONFIG_USB_SERIAL_OPTICON=m
CONFIG_USB_SERIAL_XSENS_MT=m
# CONFIG_USB_SERIAL_WISHBONE is not set
CONFIG_USB_SERIAL_SSU100=m
CONFIG_USB_SERIAL_QT2=m
# CONFIG_USB_SERIAL_UPD78F0730 is not set
CONFIG_USB_SERIAL_DEBUG=m

#
# USB Miscellaneous drivers
#
CONFIG_USB_EMI62=m
CONFIG_USB_EMI26=m
CONFIG_USB_ADUTUX=m
CONFIG_USB_SEVSEG=m
CONFIG_USB_LEGOTOWER=m
CONFIG_USB_LCD=m
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
CONFIG_USB_IDMOUSE=m
CONFIG_USB_FTDI_ELAN=m
CONFIG_USB_APPLEDISPLAY=m
CONFIG_USB_SISUSBVGA=m
CONFIG_USB_SISUSBVGA_CON=y
CONFIG_USB_LD=m
# CONFIG_USB_TRANCEVIBRATOR is not set
CONFIG_USB_IOWARRIOR=m
# CONFIG_USB_TEST is not set
# CONFIG_USB_EHSET_TEST_FIXTURE is not set
CONFIG_USB_ISIGHTFW=m
# CONFIG_USB_YUREX is not set
CONFIG_USB_EZUSB_FX2=m
# CONFIG_USB_HUB_USB251XB is not set
CONFIG_USB_HSIC_USB3503=m
# CONFIG_USB_HSIC_USB4604 is not set
# CONFIG_USB_LINK_LAYER_TEST is not set
# CONFIG_USB_CHAOSKEY is not set
CONFIG_USB_ATM=m
CONFIG_USB_SPEEDTOUCH=m
CONFIG_USB_CXACRU=m
CONFIG_USB_UEAGLEATM=m
CONFIG_USB_XUSBATM=m

#
# USB Physical Layer drivers
#
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_USB_ISP1301 is not set
# end of USB Physical Layer drivers

# CONFIG_USB_GADGET is not set
CONFIG_TYPEC=y
# CONFIG_TYPEC_TCPM is not set
CONFIG_TYPEC_UCSI=y
# CONFIG_UCSI_CCG is not set
CONFIG_UCSI_ACPI=y
# CONFIG_TYPEC_TPS6598X is not set

#
# USB Type-C Multiplexer/DeMultiplexer Switch support
#
# CONFIG_TYPEC_MUX_PI3USB30532 is not set
# end of USB Type-C Multiplexer/DeMultiplexer Switch support

#
# USB Type-C Alternate Mode drivers
#
# CONFIG_TYPEC_DP_ALTMODE is not set
# end of USB Type-C Alternate Mode drivers

# CONFIG_USB_ROLE_SWITCH is not set
CONFIG_MMC=m
CONFIG_MMC_BLOCK=m
CONFIG_MMC_BLOCK_MINORS=8
CONFIG_SDIO_UART=m
# CONFIG_MMC_TEST is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_DEBUG is not set
CONFIG_MMC_SDHCI=m
CONFIG_MMC_SDHCI_IO_ACCESSORS=y
CONFIG_MMC_SDHCI_PCI=m
CONFIG_MMC_RICOH_MMC=y
CONFIG_MMC_SDHCI_ACPI=m
CONFIG_MMC_SDHCI_PLTFM=m
# CONFIG_MMC_SDHCI_F_SDH30 is not set
# CONFIG_MMC_WBSD is not set
CONFIG_MMC_TIFM_SD=m
# CONFIG_MMC_SPI is not set
CONFIG_MMC_CB710=m
CONFIG_MMC_VIA_SDMMC=m
CONFIG_MMC_VUB300=m
CONFIG_MMC_USHC=m
# CONFIG_MMC_USDHI6ROL0 is not set
CONFIG_MMC_CQHCI=m
# CONFIG_MMC_TOSHIBA_PCI is not set
# CONFIG_MMC_MTK is not set
# CONFIG_MMC_SDHCI_XENON is not set
CONFIG_MEMSTICK=m
# CONFIG_MEMSTICK_DEBUG is not set

#
# MemoryStick drivers
#
# CONFIG_MEMSTICK_UNSAFE_RESUME is not set
CONFIG_MSPRO_BLOCK=m
# CONFIG_MS_BLOCK is not set

#
# MemoryStick Host Controller Drivers
#
CONFIG_MEMSTICK_TIFM_MS=m
CONFIG_MEMSTICK_JMICRON_38X=m
CONFIG_MEMSTICK_R592=m
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
# CONFIG_LEDS_CLASS_FLASH is not set
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
# CONFIG_LEDS_APU is not set
CONFIG_LEDS_LM3530=m
# CONFIG_LEDS_LM3532 is not set
# CONFIG_LEDS_LM3642 is not set
# CONFIG_LEDS_PCA9532 is not set
# CONFIG_LEDS_GPIO is not set
CONFIG_LEDS_LP3944=m
# CONFIG_LEDS_LP3952 is not set
CONFIG_LEDS_LP55XX_COMMON=m
CONFIG_LEDS_LP5521=m
CONFIG_LEDS_LP5523=m
CONFIG_LEDS_LP5562=m
# CONFIG_LEDS_LP8501 is not set
CONFIG_LEDS_CLEVO_MAIL=m
# CONFIG_LEDS_PCA955X is not set
# CONFIG_LEDS_PCA963X is not set
# CONFIG_LEDS_DAC124S085 is not set
# CONFIG_LEDS_PWM is not set
# CONFIG_LEDS_BD2802 is not set
CONFIG_LEDS_INTEL_SS4200=m
# CONFIG_LEDS_TCA6507 is not set
# CONFIG_LEDS_TLC591XX is not set
# CONFIG_LEDS_LM355x is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=m
# CONFIG_LEDS_MLXCPLD is not set
# CONFIG_LEDS_MLXREG is not set
# CONFIG_LEDS_USER is not set
# CONFIG_LEDS_NIC78BX is not set
# CONFIG_LEDS_TI_LMU_COMMON is not set

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=m
CONFIG_LEDS_TRIGGER_ONESHOT=m
# CONFIG_LEDS_TRIGGER_DISK is not set
# CONFIG_LEDS_TRIGGER_MTD is not set
CONFIG_LEDS_TRIGGER_HEARTBEAT=m
CONFIG_LEDS_TRIGGER_BACKLIGHT=m
# CONFIG_LEDS_TRIGGER_CPU is not set
# CONFIG_LEDS_TRIGGER_ACTIVITY is not set
CONFIG_LEDS_TRIGGER_GPIO=m
CONFIG_LEDS_TRIGGER_DEFAULT_ON=m

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=m
CONFIG_LEDS_TRIGGER_CAMERA=m
# CONFIG_LEDS_TRIGGER_PANIC is not set
# CONFIG_LEDS_TRIGGER_NETDEV is not set
# CONFIG_LEDS_TRIGGER_PATTERN is not set
CONFIG_LEDS_TRIGGER_AUDIO=m
# CONFIG_ACCESSIBILITY is not set
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=y
CONFIG_EDAC_LEGACY_SYSFS=y
# CONFIG_EDAC_DEBUG is not set
CONFIG_EDAC_DECODE_MCE=m
CONFIG_EDAC_GHES=y
CONFIG_EDAC_AMD64=m
# CONFIG_EDAC_AMD64_ERROR_INJECTION is not set
CONFIG_EDAC_E752X=m
CONFIG_EDAC_I82975X=m
CONFIG_EDAC_I3000=m
CONFIG_EDAC_I3200=m
CONFIG_EDAC_IE31200=m
CONFIG_EDAC_X38=m
CONFIG_EDAC_I5400=m
CONFIG_EDAC_I7CORE=m
CONFIG_EDAC_I5000=m
CONFIG_EDAC_I5100=m
CONFIG_EDAC_I7300=m
CONFIG_EDAC_SBRIDGE=m
CONFIG_EDAC_SKX=m
# CONFIG_EDAC_I10NM is not set
CONFIG_EDAC_PND2=m
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
# CONFIG_RTC_SYSTOHC is not set
# CONFIG_RTC_DEBUG is not set
CONFIG_RTC_NVMEM=y

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_INTF_PROC=y
CONFIG_RTC_INTF_DEV=y
# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#
# CONFIG_RTC_DRV_ABB5ZES3 is not set
# CONFIG_RTC_DRV_ABEOZ9 is not set
# CONFIG_RTC_DRV_ABX80X is not set
CONFIG_RTC_DRV_DS1307=m
# CONFIG_RTC_DRV_DS1307_CENTURY is not set
CONFIG_RTC_DRV_DS1374=m
# CONFIG_RTC_DRV_DS1374_WDT is not set
CONFIG_RTC_DRV_DS1672=m
CONFIG_RTC_DRV_MAX6900=m
CONFIG_RTC_DRV_RS5C372=m
CONFIG_RTC_DRV_ISL1208=m
CONFIG_RTC_DRV_ISL12022=m
CONFIG_RTC_DRV_X1205=m
CONFIG_RTC_DRV_PCF8523=m
# CONFIG_RTC_DRV_PCF85063 is not set
# CONFIG_RTC_DRV_PCF85363 is not set
CONFIG_RTC_DRV_PCF8563=m
CONFIG_RTC_DRV_PCF8583=m
CONFIG_RTC_DRV_M41T80=m
CONFIG_RTC_DRV_M41T80_WDT=y
CONFIG_RTC_DRV_BQ32K=m
# CONFIG_RTC_DRV_S35390A is not set
CONFIG_RTC_DRV_FM3130=m
# CONFIG_RTC_DRV_RX8010 is not set
CONFIG_RTC_DRV_RX8581=m
CONFIG_RTC_DRV_RX8025=m
CONFIG_RTC_DRV_EM3027=m
# CONFIG_RTC_DRV_RV3028 is not set
# CONFIG_RTC_DRV_RV8803 is not set
# CONFIG_RTC_DRV_SD3078 is not set

#
# SPI RTC drivers
#
# CONFIG_RTC_DRV_M41T93 is not set
# CONFIG_RTC_DRV_M41T94 is not set
# CONFIG_RTC_DRV_DS1302 is not set
# CONFIG_RTC_DRV_DS1305 is not set
# CONFIG_RTC_DRV_DS1343 is not set
# CONFIG_RTC_DRV_DS1347 is not set
# CONFIG_RTC_DRV_DS1390 is not set
# CONFIG_RTC_DRV_MAX6916 is not set
# CONFIG_RTC_DRV_R9701 is not set
CONFIG_RTC_DRV_RX4581=m
# CONFIG_RTC_DRV_RX6110 is not set
# CONFIG_RTC_DRV_RS5C348 is not set
# CONFIG_RTC_DRV_MAX6902 is not set
# CONFIG_RTC_DRV_PCF2123 is not set
# CONFIG_RTC_DRV_MCP795 is not set
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
CONFIG_RTC_DRV_DS3232=m
CONFIG_RTC_DRV_DS3232_HWMON=y
# CONFIG_RTC_DRV_PCF2127 is not set
CONFIG_RTC_DRV_RV3029C2=m
CONFIG_RTC_DRV_RV3029_HWMON=y

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=y
CONFIG_RTC_DRV_DS1286=m
CONFIG_RTC_DRV_DS1511=m
CONFIG_RTC_DRV_DS1553=m
# CONFIG_RTC_DRV_DS1685_FAMILY is not set
CONFIG_RTC_DRV_DS1742=m
CONFIG_RTC_DRV_DS2404=m
CONFIG_RTC_DRV_STK17TA8=m
# CONFIG_RTC_DRV_M48T86 is not set
CONFIG_RTC_DRV_M48T35=m
CONFIG_RTC_DRV_M48T59=m
CONFIG_RTC_DRV_MSM6242=m
CONFIG_RTC_DRV_BQ4802=m
CONFIG_RTC_DRV_RP5C01=m
CONFIG_RTC_DRV_V3020=m

#
# on-CPU RTC drivers
#
# CONFIG_RTC_DRV_FTRTC010 is not set

#
# HID Sensor RTC drivers
#
# CONFIG_RTC_DRV_HID_SENSOR_TIME is not set
CONFIG_DMADEVICES=y
# CONFIG_DMADEVICES_DEBUG is not set

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
# CONFIG_ALTERA_MSGDMA is not set
# CONFIG_INTEL_IDMA64 is not set
CONFIG_INTEL_IOATDMA=m
# CONFIG_QCOM_HIDMA_MGMT is not set
# CONFIG_QCOM_HIDMA is not set
CONFIG_DW_DMAC_CORE=y
CONFIG_DW_DMAC=m
CONFIG_DW_DMAC_PCI=y
# CONFIG_DW_EDMA is not set
# CONFIG_DW_EDMA_PCIE is not set
CONFIG_HSU_DMA=y

#
# DMA Clients
#
CONFIG_ASYNC_TX_DMA=y
# CONFIG_DMATEST is not set
CONFIG_DMA_ENGINE_RAID=y

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
CONFIG_SW_SYNC=y
# CONFIG_UDMABUF is not set
# CONFIG_DMABUF_SELFTESTS is not set
# end of DMABUF options

CONFIG_DCA=m
CONFIG_AUXDISPLAY=y
# CONFIG_HD44780 is not set
CONFIG_KS0108=m
CONFIG_KS0108_PORT=0x378
CONFIG_KS0108_DELAY=2
CONFIG_CFAG12864B=m
CONFIG_CFAG12864B_RATE=20
# CONFIG_IMG_ASCII_LCD is not set
# CONFIG_PARPORT_PANEL is not set
# CONFIG_CHARLCD_BL_OFF is not set
# CONFIG_CHARLCD_BL_ON is not set
CONFIG_CHARLCD_BL_FLASH=y
# CONFIG_PANEL is not set
CONFIG_UIO=m
CONFIG_UIO_CIF=m
CONFIG_UIO_PDRV_GENIRQ=m
# CONFIG_UIO_DMEM_GENIRQ is not set
CONFIG_UIO_AEC=m
CONFIG_UIO_SERCOS3=m
CONFIG_UIO_PCI_GENERIC=m
# CONFIG_UIO_NETX is not set
# CONFIG_UIO_PRUSS is not set
# CONFIG_UIO_MF624 is not set
CONFIG_UIO_HV_GENERIC=m
CONFIG_VFIO_IOMMU_TYPE1=m
CONFIG_VFIO_VIRQFD=m
CONFIG_VFIO=m
CONFIG_VFIO_NOIOMMU=y
CONFIG_VFIO_PCI=m
# CONFIG_VFIO_PCI_VGA is not set
CONFIG_VFIO_PCI_MMAP=y
CONFIG_VFIO_PCI_INTX=y
# CONFIG_VFIO_PCI_IGD is not set
CONFIG_VFIO_MDEV=m
CONFIG_VFIO_MDEV_DEVICE=m
CONFIG_IRQ_BYPASS_MANAGER=m
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO=y
CONFIG_VIRTIO_MENU=y
CONFIG_VIRTIO_PCI=y
CONFIG_VIRTIO_PCI_LEGACY=y
# CONFIG_VIRTIO_PMEM is not set
CONFIG_VIRTIO_BALLOON=y
CONFIG_VIRTIO_INPUT=m
# CONFIG_VIRTIO_MMIO is not set

#
# Microsoft Hyper-V guest support
#
CONFIG_HYPERV=m
CONFIG_HYPERV_TIMER=y
CONFIG_HYPERV_UTILS=m
CONFIG_HYPERV_BALLOON=m
# end of Microsoft Hyper-V guest support

#
# Xen driver support
#
CONFIG_XEN_BALLOON=y
# CONFIG_XEN_BALLOON_MEMORY_HOTPLUG is not set
CONFIG_XEN_SCRUB_PAGES_DEFAULT=y
CONFIG_XEN_DEV_EVTCHN=m
# CONFIG_XEN_BACKEND is not set
CONFIG_XENFS=m
CONFIG_XEN_COMPAT_XENFS=y
CONFIG_XEN_SYS_HYPERVISOR=y
CONFIG_XEN_XENBUS_FRONTEND=y
# CONFIG_XEN_GNTDEV is not set
# CONFIG_XEN_GRANT_DEV_ALLOC is not set
# CONFIG_XEN_GRANT_DMA_ALLOC is not set
CONFIG_SWIOTLB_XEN=y
# CONFIG_XEN_PVCALLS_FRONTEND is not set
CONFIG_XEN_PRIVCMD=m
CONFIG_XEN_HAVE_PVMMU=y
CONFIG_XEN_EFI=y
CONFIG_XEN_AUTO_XLATE=y
CONFIG_XEN_ACPI=y
CONFIG_XEN_HAVE_VPMU=y
# end of Xen driver support

# CONFIG_GREYBUS is not set
CONFIG_STAGING=y
# CONFIG_PRISM2_USB is not set
# CONFIG_COMEDI is not set
# CONFIG_RTL8192U is not set
CONFIG_RTLLIB=m
CONFIG_RTLLIB_CRYPTO_CCMP=m
CONFIG_RTLLIB_CRYPTO_TKIP=m
CONFIG_RTLLIB_CRYPTO_WEP=m
CONFIG_RTL8192E=m
# CONFIG_RTL8723BS is not set
CONFIG_R8712U=m
# CONFIG_R8188EU is not set
# CONFIG_RTS5208 is not set
# CONFIG_VT6655 is not set
# CONFIG_VT6656 is not set

#
# IIO staging drivers
#

#
# Accelerometers
#
# CONFIG_ADIS16203 is not set
# CONFIG_ADIS16240 is not set
# end of Accelerometers

#
# Analog to digital converters
#
# CONFIG_AD7816 is not set
# CONFIG_AD7192 is not set
# CONFIG_AD7280 is not set
# end of Analog to digital converters

#
# Analog digital bi-direction converters
#
# CONFIG_ADT7316 is not set
# end of Analog digital bi-direction converters

#
# Capacitance to digital converters
#
# CONFIG_AD7150 is not set
# CONFIG_AD7746 is not set
# end of Capacitance to digital converters

#
# Direct Digital Synthesis
#
# CONFIG_AD9832 is not set
# CONFIG_AD9834 is not set
# end of Direct Digital Synthesis

#
# Network Analyzer, Impedance Converters
#
# CONFIG_AD5933 is not set
# end of Network Analyzer, Impedance Converters

#
# Active energy metering IC
#
# CONFIG_ADE7854 is not set
# end of Active energy metering IC

#
# Resolver to digital converters
#
# CONFIG_AD2S1210 is not set
# end of Resolver to digital converters
# end of IIO staging drivers

# CONFIG_FB_SM750 is not set

#
# Speakup console speech
#
# CONFIG_SPEAKUP is not set
# end of Speakup console speech

# CONFIG_STAGING_MEDIA is not set

#
# Android
#
# CONFIG_ASHMEM is not set
# CONFIG_ANDROID_VSOC is not set
CONFIG_ION=y
CONFIG_ION_SYSTEM_HEAP=y
# CONFIG_ION_CMA_HEAP is not set
# end of Android

# CONFIG_LTE_GDM724X is not set
CONFIG_FIREWIRE_SERIAL=m
CONFIG_FWTTY_MAX_TOTAL_PORTS=64
CONFIG_FWTTY_MAX_CARD_PORTS=32
# CONFIG_GS_FPGABOOT is not set
# CONFIG_UNISYSSPAR is not set
# CONFIG_WILC1000_SDIO is not set
# CONFIG_WILC1000_SPI is not set
# CONFIG_MOST is not set
# CONFIG_KS7010 is not set
# CONFIG_PI433 is not set

#
# Gasket devices
#
# CONFIG_STAGING_GASKET_FRAMEWORK is not set
# end of Gasket devices

# CONFIG_FIELDBUS_DEV is not set
# CONFIG_KPC2000 is not set

#
# ISDN CAPI drivers
#
CONFIG_CAPI_AVM=y
CONFIG_ISDN_DRV_AVMB1_B1PCI=m
CONFIG_ISDN_DRV_AVMB1_B1PCIV4=y
CONFIG_ISDN_DRV_AVMB1_T1PCI=m
CONFIG_ISDN_DRV_AVMB1_C4=m
CONFIG_ISDN_DRV_GIGASET=m
CONFIG_GIGASET_CAPI=y
CONFIG_GIGASET_BASE=m
CONFIG_GIGASET_M105=m
CONFIG_GIGASET_M101=m
# CONFIG_GIGASET_DEBUG is not set
CONFIG_HYSDN=m
CONFIG_HYSDN_CAPI=y
# end of ISDN CAPI drivers

CONFIG_USB_WUSB=m
CONFIG_USB_WUSB_CBAF=m
# CONFIG_USB_WUSB_CBAF_DEBUG is not set
# CONFIG_USB_WHCI_HCD is not set
CONFIG_USB_HWA_HCD=m
CONFIG_UWB=m
CONFIG_UWB_HWA=m
CONFIG_UWB_WHCI=m
CONFIG_UWB_I1480U=m
# CONFIG_EXFAT_FS is not set
CONFIG_QLGE=m
CONFIG_X86_PLATFORM_DEVICES=y
CONFIG_ACER_WMI=m
# CONFIG_ACER_WIRELESS is not set
CONFIG_ACERHDF=m
# CONFIG_ALIENWARE_WMI is not set
CONFIG_ASUS_LAPTOP=m
CONFIG_DCDBAS=m
CONFIG_DELL_SMBIOS=m
CONFIG_DELL_SMBIOS_WMI=y
CONFIG_DELL_SMBIOS_SMM=y
CONFIG_DELL_LAPTOP=m
CONFIG_DELL_WMI=m
CONFIG_DELL_WMI_DESCRIPTOR=m
CONFIG_DELL_WMI_AIO=m
# CONFIG_DELL_WMI_LED is not set
CONFIG_DELL_SMO8800=m
CONFIG_DELL_RBTN=m
CONFIG_DELL_RBU=m
CONFIG_FUJITSU_LAPTOP=m
CONFIG_FUJITSU_TABLET=m
CONFIG_AMILO_RFKILL=m
# CONFIG_GPD_POCKET_FAN is not set
CONFIG_HP_ACCEL=m
CONFIG_HP_WIRELESS=m
CONFIG_HP_WMI=m
# CONFIG_LG_LAPTOP is not set
CONFIG_MSI_LAPTOP=m
CONFIG_PANASONIC_LAPTOP=m
CONFIG_COMPAL_LAPTOP=m
CONFIG_SONY_LAPTOP=m
CONFIG_SONYPI_COMPAT=y
CONFIG_IDEAPAD_LAPTOP=m
# CONFIG_SURFACE3_WMI is not set
CONFIG_THINKPAD_ACPI=m
CONFIG_THINKPAD_ACPI_ALSA_SUPPORT=y
# CONFIG_THINKPAD_ACPI_DEBUGFACILITIES is not set
# CONFIG_THINKPAD_ACPI_DEBUG is not set
# CONFIG_THINKPAD_ACPI_UNSAFE_LEDS is not set
CONFIG_THINKPAD_ACPI_VIDEO=y
CONFIG_THINKPAD_ACPI_HOTKEY_POLL=y
CONFIG_SENSORS_HDAPS=m
# CONFIG_INTEL_MENLOW is not set
CONFIG_EEEPC_LAPTOP=m
CONFIG_ASUS_WMI=m
CONFIG_ASUS_NB_WMI=m
CONFIG_EEEPC_WMI=m
# CONFIG_ASUS_WIRELESS is not set
CONFIG_ACPI_WMI=m
CONFIG_WMI_BMOF=m
CONFIG_INTEL_WMI_THUNDERBOLT=m
# CONFIG_XIAOMI_WMI is not set
CONFIG_MSI_WMI=m
# CONFIG_PEAQ_WMI is not set
CONFIG_TOPSTAR_LAPTOP=m
CONFIG_ACPI_TOSHIBA=m
CONFIG_TOSHIBA_BT_RFKILL=m
# CONFIG_TOSHIBA_HAPS is not set
# CONFIG_TOSHIBA_WMI is not set
CONFIG_ACPI_CMPC=m
# CONFIG_INTEL_INT0002_VGPIO is not set
CONFIG_INTEL_HID_EVENT=m
CONFIG_INTEL_VBTN=m
CONFIG_INTEL_IPS=m
CONFIG_INTEL_PMC_CORE=m
# CONFIG_IBM_RTL is not set
CONFIG_SAMSUNG_LAPTOP=m
CONFIG_MXM_WMI=m
CONFIG_INTEL_OAKTRAIL=m
CONFIG_SAMSUNG_Q10=m
CONFIG_APPLE_GMUX=m
# CONFIG_INTEL_RST is not set
# CONFIG_INTEL_SMARTCONNECT is not set
# CONFIG_INTEL_PMC_IPC is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
# CONFIG_INTEL_PUNIT_IPC is not set
# CONFIG_MLX_PLATFORM is not set
# CONFIG_INTEL_TURBO_MAX_3 is not set
# CONFIG_I2C_MULTI_INSTANTIATE is not set
# CONFIG_INTEL_ATOMISP2_PM is not set
# CONFIG_HUAWEI_WMI is not set
# CONFIG_PCENGINES_APU2 is not set

#
# Intel Speed Select Technology interface support
#
# CONFIG_INTEL_SPEED_SELECT_INTERFACE is not set
# end of Intel Speed Select Technology interface support

CONFIG_PMC_ATOM=y
# CONFIG_MFD_CROS_EC is not set
# CONFIG_CHROME_PLATFORMS is not set
# CONFIG_MELLANOX_PLATFORM is not set
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y

#
# Common Clock Framework
#
# CONFIG_COMMON_CLK_MAX9485 is not set
# CONFIG_COMMON_CLK_SI5341 is not set
# CONFIG_COMMON_CLK_SI5351 is not set
# CONFIG_COMMON_CLK_SI544 is not set
# CONFIG_COMMON_CLK_CDCE706 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_COMMON_CLK_PWM is not set
# end of Common Clock Framework

# CONFIG_HWSPINLOCK is not set

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
# end of Clock Source drivers

CONFIG_MAILBOX=y
CONFIG_PCC=y
# CONFIG_ALTERA_MBOX is not set
CONFIG_IOMMU_IOVA=y
CONFIG_IOMMU_API=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
# end of Generic IOMMU Pagetable Support

# CONFIG_IOMMU_DEBUGFS is not set
# CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set
CONFIG_AMD_IOMMU=y
CONFIG_AMD_IOMMU_V2=m
CONFIG_DMAR_TABLE=y
CONFIG_INTEL_IOMMU=y
# CONFIG_INTEL_IOMMU_SVM is not set
# CONFIG_INTEL_IOMMU_DEFAULT_ON is not set
CONFIG_INTEL_IOMMU_FLOPPY_WA=y
CONFIG_IRQ_REMAP=y
CONFIG_HYPERV_IOMMU=y

#
# Remoteproc drivers
#
# CONFIG_REMOTEPROC is not set
# end of Remoteproc drivers

#
# Rpmsg drivers
#
# CONFIG_RPMSG_QCOM_GLINK_RPM is not set
# CONFIG_RPMSG_VIRTIO is not set
# end of Rpmsg drivers

# CONFIG_SOUNDWIRE is not set

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#
# end of Amlogic SoC drivers

#
# Aspeed SoC drivers
#
# end of Aspeed SoC drivers

#
# Broadcom SoC drivers
#
# end of Broadcom SoC drivers

#
# NXP/Freescale QorIQ SoC drivers
#
# end of NXP/Freescale QorIQ SoC drivers

#
# i.MX SoC drivers
#
# end of i.MX SoC drivers

#
# Qualcomm SoC drivers
#
# end of Qualcomm SoC drivers

# CONFIG_SOC_TI is not set

#
# Xilinx SoC drivers
#
# CONFIG_XILINX_VCU is not set
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

CONFIG_PM_DEVFREQ=y

#
# DEVFREQ Governors
#
CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=m
# CONFIG_DEVFREQ_GOV_PERFORMANCE is not set
# CONFIG_DEVFREQ_GOV_POWERSAVE is not set
# CONFIG_DEVFREQ_GOV_USERSPACE is not set
# CONFIG_DEVFREQ_GOV_PASSIVE is not set

#
# DEVFREQ Drivers
#
# CONFIG_PM_DEVFREQ_EVENT is not set
# CONFIG_EXTCON is not set
# CONFIG_MEMORY is not set
CONFIG_IIO=y
CONFIG_IIO_BUFFER=y
CONFIG_IIO_BUFFER_CB=y
# CONFIG_IIO_BUFFER_HW_CONSUMER is not set
CONFIG_IIO_KFIFO_BUF=y
CONFIG_IIO_TRIGGERED_BUFFER=m
# CONFIG_IIO_CONFIGFS is not set
CONFIG_IIO_TRIGGER=y
CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
# CONFIG_IIO_SW_DEVICE is not set
# CONFIG_IIO_SW_TRIGGER is not set

#
# Accelerometers
#
# CONFIG_ADIS16201 is not set
# CONFIG_ADIS16209 is not set
# CONFIG_ADXL345_I2C is not set
# CONFIG_ADXL345_SPI is not set
# CONFIG_ADXL372_SPI is not set
# CONFIG_ADXL372_I2C is not set
# CONFIG_BMA180 is not set
# CONFIG_BMA220 is not set
# CONFIG_BMC150_ACCEL is not set
# CONFIG_DA280 is not set
# CONFIG_DA311 is not set
# CONFIG_DMARD09 is not set
# CONFIG_DMARD10 is not set
CONFIG_HID_SENSOR_ACCEL_3D=m
# CONFIG_IIO_ST_ACCEL_3AXIS is not set
# CONFIG_KXSD9 is not set
# CONFIG_KXCJK1013 is not set
# CONFIG_MC3230 is not set
# CONFIG_MMA7455_I2C is not set
# CONFIG_MMA7455_SPI is not set
# CONFIG_MMA7660 is not set
# CONFIG_MMA8452 is not set
# CONFIG_MMA9551 is not set
# CONFIG_MMA9553 is not set
# CONFIG_MXC4005 is not set
# CONFIG_MXC6255 is not set
# CONFIG_SCA3000 is not set
# CONFIG_STK8312 is not set
# CONFIG_STK8BA50 is not set
# end of Accelerometers

#
# Analog to digital converters
#
# CONFIG_AD7124 is not set
# CONFIG_AD7266 is not set
# CONFIG_AD7291 is not set
# CONFIG_AD7298 is not set
# CONFIG_AD7476 is not set
# CONFIG_AD7606_IFACE_PARALLEL is not set
# CONFIG_AD7606_IFACE_SPI is not set
# CONFIG_AD7766 is not set
# CONFIG_AD7768_1 is not set
# CONFIG_AD7780 is not set
# CONFIG_AD7791 is not set
# CONFIG_AD7793 is not set
# CONFIG_AD7887 is not set
# CONFIG_AD7923 is not set
# CONFIG_AD7949 is not set
# CONFIG_AD799X is not set
# CONFIG_HI8435 is not set
# CONFIG_HX711 is not set
# CONFIG_INA2XX_ADC is not set
# CONFIG_LTC2471 is not set
# CONFIG_LTC2485 is not set
# CONFIG_LTC2497 is not set
# CONFIG_MAX1027 is not set
# CONFIG_MAX11100 is not set
# CONFIG_MAX1118 is not set
# CONFIG_MAX1363 is not set
# CONFIG_MAX9611 is not set
# CONFIG_MCP320X is not set
# CONFIG_MCP3422 is not set
# CONFIG_MCP3911 is not set
# CONFIG_NAU7802 is not set
# CONFIG_TI_ADC081C is not set
# CONFIG_TI_ADC0832 is not set
# CONFIG_TI_ADC084S021 is not set
# CONFIG_TI_ADC12138 is not set
# CONFIG_TI_ADC108S102 is not set
# CONFIG_TI_ADC128S052 is not set
# CONFIG_TI_ADC161S626 is not set
# CONFIG_TI_ADS1015 is not set
# CONFIG_TI_ADS7950 is not set
# CONFIG_TI_TLC4541 is not set
# CONFIG_VIPERBOARD_ADC is not set
# CONFIG_XILINX_XADC is not set
# end of Analog to digital converters

#
# Analog Front Ends
#
# end of Analog Front Ends

#
# Amplifiers
#
# CONFIG_AD8366 is not set
# end of Amplifiers

#
# Chemical Sensors
#
# CONFIG_ATLAS_PH_SENSOR is not set
# CONFIG_BME680 is not set
# CONFIG_CCS811 is not set
# CONFIG_IAQCORE is not set
# CONFIG_SENSIRION_SGP30 is not set
# CONFIG_SPS30 is not set
# CONFIG_VZ89X is not set
# end of Chemical Sensors

#
# Hid Sensor IIO Common
#
CONFIG_HID_SENSOR_IIO_COMMON=m
CONFIG_HID_SENSOR_IIO_TRIGGER=m
# end of Hid Sensor IIO Common

#
# SSP Sensor Common
#
# CONFIG_IIO_SSP_SENSORHUB is not set
# end of SSP Sensor Common

#
# Digital to analog converters
#
# CONFIG_AD5064 is not set
# CONFIG_AD5360 is not set
# CONFIG_AD5380 is not set
# CONFIG_AD5421 is not set
# CONFIG_AD5446 is not set
# CONFIG_AD5449 is not set
# CONFIG_AD5592R is not set
# CONFIG_AD5593R is not set
# CONFIG_AD5504 is not set
# CONFIG_AD5624R_SPI is not set
# CONFIG_LTC1660 is not set
# CONFIG_LTC2632 is not set
# CONFIG_AD5686_SPI is not set
# CONFIG_AD5696_I2C is not set
# CONFIG_AD5755 is not set
# CONFIG_AD5758 is not set
# CONFIG_AD5761 is not set
# CONFIG_AD5764 is not set
# CONFIG_AD5791 is not set
# CONFIG_AD7303 is not set
# CONFIG_AD8801 is not set
# CONFIG_DS4424 is not set
# CONFIG_M62332 is not set
# CONFIG_MAX517 is not set
# CONFIG_MCP4725 is not set
# CONFIG_MCP4922 is not set
# CONFIG_TI_DAC082S085 is not set
# CONFIG_TI_DAC5571 is not set
# CONFIG_TI_DAC7311 is not set
# CONFIG_TI_DAC7612 is not set
# end of Digital to analog converters

#
# IIO dummy driver
#
# end of IIO dummy driver

#
# Frequency Synthesizers DDS/PLL
#

#
# Clock Generator/Distribution
#
# CONFIG_AD9523 is not set
# end of Clock Generator/Distribution

#
# Phase-Locked Loop (PLL) frequency synthesizers
#
# CONFIG_ADF4350 is not set
# CONFIG_ADF4371 is not set
# end of Phase-Locked Loop (PLL) frequency synthesizers
# end of Frequency Synthesizers DDS/PLL

#
# Digital gyroscope sensors
#
# CONFIG_ADIS16080 is not set
# CONFIG_ADIS16130 is not set
# CONFIG_ADIS16136 is not set
# CONFIG_ADIS16260 is not set
# CONFIG_ADXRS450 is not set
# CONFIG_BMG160 is not set
# CONFIG_FXAS21002C is not set
CONFIG_HID_SENSOR_GYRO_3D=m
# CONFIG_MPU3050_I2C is not set
# CONFIG_IIO_ST_GYRO_3AXIS is not set
# CONFIG_ITG3200 is not set
# end of Digital gyroscope sensors

#
# Health Sensors
#

#
# Heart Rate Monitors
#
# CONFIG_AFE4403 is not set
# CONFIG_AFE4404 is not set
# CONFIG_MAX30100 is not set
# CONFIG_MAX30102 is not set
# end of Heart Rate Monitors
# end of Health Sensors

#
# Humidity sensors
#
# CONFIG_AM2315 is not set
# CONFIG_DHT11 is not set
# CONFIG_HDC100X is not set
# CONFIG_HID_SENSOR_HUMIDITY is not set
# CONFIG_HTS221 is not set
# CONFIG_HTU21 is not set
# CONFIG_SI7005 is not set
# CONFIG_SI7020 is not set
# end of Humidity sensors

#
# Inertial measurement units
#
# CONFIG_ADIS16400 is not set
# CONFIG_ADIS16460 is not set
# CONFIG_ADIS16480 is not set
# CONFIG_BMI160_I2C is not set
# CONFIG_BMI160_SPI is not set
# CONFIG_KMX61 is not set
# CONFIG_INV_MPU6050_I2C is not set
# CONFIG_INV_MPU6050_SPI is not set
# CONFIG_IIO_ST_LSM6DSX is not set
# end of Inertial measurement units

#
# Light sensors
#
# CONFIG_ACPI_ALS is not set
# CONFIG_ADJD_S311 is not set
# CONFIG_AL3320A is not set
# CONFIG_APDS9300 is not set
# CONFIG_APDS9960 is not set
# CONFIG_BH1750 is not set
# CONFIG_BH1780 is not set
# CONFIG_CM32181 is not set
# CONFIG_CM3232 is not set
# CONFIG_CM3323 is not set
# CONFIG_CM36651 is not set
# CONFIG_GP2AP020A00F is not set
# CONFIG_SENSORS_ISL29018 is not set
# CONFIG_SENSORS_ISL29028 is not set
# CONFIG_ISL29125 is not set
CONFIG_HID_SENSOR_ALS=m
CONFIG_HID_SENSOR_PROX=m
# CONFIG_JSA1212 is not set
# CONFIG_RPR0521 is not set
# CONFIG_LTR501 is not set
# CONFIG_LV0104CS is not set
# CONFIG_MAX44000 is not set
# CONFIG_MAX44009 is not set
# CONFIG_NOA1305 is not set
# CONFIG_OPT3001 is not set
# CONFIG_PA12203001 is not set
# CONFIG_SI1133 is not set
# CONFIG_SI1145 is not set
# CONFIG_STK3310 is not set
# CONFIG_ST_UVIS25 is not set
# CONFIG_TCS3414 is not set
# CONFIG_TCS3472 is not set
# CONFIG_SENSORS_TSL2563 is not set
# CONFIG_TSL2583 is not set
# CONFIG_TSL2772 is not set
# CONFIG_TSL4531 is not set
# CONFIG_US5182D is not set
# CONFIG_VCNL4000 is not set
# CONFIG_VCNL4035 is not set
# CONFIG_VEML6070 is not set
# CONFIG_VL6180 is not set
# CONFIG_ZOPT2201 is not set
# end of Light sensors

#
# Magnetometer sensors
#
# CONFIG_AK8975 is not set
# CONFIG_AK09911 is not set
# CONFIG_BMC150_MAGN_I2C is not set
# CONFIG_BMC150_MAGN_SPI is not set
# CONFIG_MAG3110 is not set
CONFIG_HID_SENSOR_MAGNETOMETER_3D=m
# CONFIG_MMC35240 is not set
# CONFIG_IIO_ST_MAGN_3AXIS is not set
# CONFIG_SENSORS_HMC5843_I2C is not set
# CONFIG_SENSORS_HMC5843_SPI is not set
# CONFIG_SENSORS_RM3100_I2C is not set
# CONFIG_SENSORS_RM3100_SPI is not set
# end of Magnetometer sensors

#
# Multiplexers
#
# end of Multiplexers

#
# Inclinometer sensors
#
CONFIG_HID_SENSOR_INCLINOMETER_3D=m
CONFIG_HID_SENSOR_DEVICE_ROTATION=m
# end of Inclinometer sensors

#
# Triggers - standalone
#
# CONFIG_IIO_INTERRUPT_TRIGGER is not set
# CONFIG_IIO_SYSFS_TRIGGER is not set
# end of Triggers - standalone

#
# Digital potentiometers
#
# CONFIG_AD5272 is not set
# CONFIG_DS1803 is not set
# CONFIG_MAX5432 is not set
# CONFIG_MAX5481 is not set
# CONFIG_MAX5487 is not set
# CONFIG_MCP4018 is not set
# CONFIG_MCP4131 is not set
# CONFIG_MCP4531 is not set
# CONFIG_MCP41010 is not set
# CONFIG_TPL0102 is not set
# end of Digital potentiometers

#
# Digital potentiostats
#
# CONFIG_LMP91000 is not set
# end of Digital potentiostats

#
# Pressure sensors
#
# CONFIG_ABP060MG is not set
# CONFIG_BMP280 is not set
# CONFIG_DPS310 is not set
CONFIG_HID_SENSOR_PRESS=m
# CONFIG_HP03 is not set
# CONFIG_MPL115_I2C is not set
# CONFIG_MPL115_SPI is not set
# CONFIG_MPL3115 is not set
# CONFIG_MS5611 is not set
# CONFIG_MS5637 is not set
# CONFIG_IIO_ST_PRESS is not set
# CONFIG_T5403 is not set
# CONFIG_HP206C is not set
# CONFIG_ZPA2326 is not set
# end of Pressure sensors

#
# Lightning sensors
#
# CONFIG_AS3935 is not set
# end of Lightning sensors

#
# Proximity and distance sensors
#
# CONFIG_ISL29501 is not set
# CONFIG_LIDAR_LITE_V2 is not set
# CONFIG_MB1232 is not set
# CONFIG_RFD77402 is not set
# CONFIG_SRF04 is not set
# CONFIG_SX9500 is not set
# CONFIG_SRF08 is not set
# CONFIG_VL53L0X_I2C is not set
# end of Proximity and distance sensors

#
# Resolver to digital converters
#
# CONFIG_AD2S90 is not set
# CONFIG_AD2S1200 is not set
# end of Resolver to digital converters

#
# Temperature sensors
#
# CONFIG_MAXIM_THERMOCOUPLE is not set
# CONFIG_HID_SENSOR_TEMP is not set
# CONFIG_MLX90614 is not set
# CONFIG_MLX90632 is not set
# CONFIG_TMP006 is not set
# CONFIG_TMP007 is not set
# CONFIG_TSYS01 is not set
# CONFIG_TSYS02D is not set
# CONFIG_MAX31856 is not set
# end of Temperature sensors

CONFIG_NTB=m
# CONFIG_NTB_MSI is not set
CONFIG_NTB_AMD=m
# CONFIG_NTB_IDT is not set
# CONFIG_NTB_INTEL is not set
# CONFIG_NTB_SWITCHTEC is not set
# CONFIG_NTB_PINGPONG is not set
# CONFIG_NTB_TOOL is not set
CONFIG_NTB_PERF=m
CONFIG_NTB_TRANSPORT=m
# CONFIG_VME_BUS is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
# CONFIG_PWM_LPSS_PCI is not set
# CONFIG_PWM_LPSS_PLATFORM is not set
# CONFIG_PWM_PCA9685 is not set

#
# IRQ chip support
#
# end of IRQ chip support

# CONFIG_IPACK_BUS is not set
# CONFIG_RESET_CONTROLLER is not set

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
# CONFIG_BCM_KONA_USB2_PHY is not set
# CONFIG_PHY_PXA_28NM_HSIC is not set
# CONFIG_PHY_PXA_28NM_USB2 is not set
# CONFIG_PHY_CPCAP_USB is not set
# end of PHY Subsystem

CONFIG_POWERCAP=y
CONFIG_INTEL_RAPL_CORE=m
CONFIG_INTEL_RAPL=m
# CONFIG_IDLE_INJECT is not set
# CONFIG_MCB is not set

#
# Performance monitor support
#
# end of Performance monitor support

CONFIG_RAS=y
# CONFIG_RAS_CEC is not set
CONFIG_THUNDERBOLT=y

#
# Android
#
CONFIG_ANDROID=y
# CONFIG_ANDROID_BINDER_IPC is not set
# end of Android

CONFIG_LIBNVDIMM=m
CONFIG_BLK_DEV_PMEM=m
CONFIG_ND_BLK=m
CONFIG_ND_CLAIM=y
CONFIG_ND_BTT=m
CONFIG_BTT=y
CONFIG_ND_PFN=m
CONFIG_NVDIMM_PFN=y
CONFIG_NVDIMM_DAX=y
CONFIG_NVDIMM_KEYS=y
CONFIG_DAX_DRIVER=y
CONFIG_DAX=y
CONFIG_DEV_DAX=y
CONFIG_DEV_DAX_PMEM=m
CONFIG_DEV_DAX_KMEM=y
CONFIG_DEV_DAX_PMEM_COMPAT=m
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y

#
# HW tracing support
#
# CONFIG_STM is not set
# CONFIG_INTEL_TH is not set
# end of HW tracing support

# CONFIG_FPGA is not set
CONFIG_PM_OPP=y
# CONFIG_UNISYS_VISORBUS is not set
# CONFIG_SIOX is not set
# CONFIG_SLIMBUS is not set
# CONFIG_INTERCONNECT is not set
# CONFIG_COUNTER is not set
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
# CONFIG_VALIDATE_FS_PARSER is not set
CONFIG_FS_IOMAP=y
# CONFIG_EXT2_FS is not set
# CONFIG_EXT3_FS is not set
CONFIG_EXT4_FS=m
CONFIG_EXT4_USE_FOR_EXT2=y
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=m
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=m
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_XFS_FS=m
CONFIG_XFS_QUOTA=y
CONFIG_XFS_POSIX_ACL=y
CONFIG_XFS_RT=y
CONFIG_XFS_ONLINE_SCRUB=y
CONFIG_XFS_ONLINE_REPAIR=y
CONFIG_XFS_DEBUG=y
CONFIG_XFS_ASSERT_FATAL=y
CONFIG_GFS2_FS=m
CONFIG_GFS2_FS_LOCKING_DLM=y
CONFIG_OCFS2_FS=m
CONFIG_OCFS2_FS_O2CB=m
CONFIG_OCFS2_FS_USERSPACE_CLUSTER=m
CONFIG_OCFS2_FS_STATS=y
CONFIG_OCFS2_DEBUG_MASKLOG=y
# CONFIG_OCFS2_DEBUG_FS is not set
CONFIG_BTRFS_FS=m
CONFIG_BTRFS_FS_POSIX_ACL=y
# CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
# CONFIG_BTRFS_DEBUG is not set
# CONFIG_BTRFS_ASSERT is not set
# CONFIG_BTRFS_FS_REF_VERIFY is not set
# CONFIG_NILFS2_FS is not set
CONFIG_F2FS_FS=m
CONFIG_F2FS_STAT_FS=y
CONFIG_F2FS_FS_XATTR=y
CONFIG_F2FS_FS_POSIX_ACL=y
# CONFIG_F2FS_FS_SECURITY is not set
# CONFIG_F2FS_CHECK_FS is not set
# CONFIG_F2FS_IO_TRACE is not set
# CONFIG_F2FS_FAULT_INJECTION is not set
CONFIG_FS_DAX=y
CONFIG_FS_DAX_PMD=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
CONFIG_MANDATORY_FILE_LOCKING=y
CONFIG_FS_ENCRYPTION=y
# CONFIG_FS_VERITY is not set
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
CONFIG_FANOTIFY_ACCESS_PERMISSIONS=y
CONFIG_QUOTA=y
CONFIG_QUOTA_NETLINK_INTERFACE=y
CONFIG_PRINT_QUOTA_WARNING=y
# CONFIG_QUOTA_DEBUG is not set
CONFIG_QUOTA_TREE=y
# CONFIG_QFMT_V1 is not set
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
CONFIG_QUOTACTL_COMPAT=y
CONFIG_AUTOFS4_FS=y
CONFIG_AUTOFS_FS=y
CONFIG_FUSE_FS=m
CONFIG_CUSE=m
# CONFIG_VIRTIO_FS is not set
CONFIG_OVERLAY_FS=m
# CONFIG_OVERLAY_FS_REDIRECT_DIR is not set
# CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW is not set
# CONFIG_OVERLAY_FS_INDEX is not set
# CONFIG_OVERLAY_FS_XINO_AUTO is not set
# CONFIG_OVERLAY_FS_METACOPY is not set

#
# Caches
#
CONFIG_FSCACHE=m
CONFIG_FSCACHE_STATS=y
# CONFIG_FSCACHE_HISTOGRAM is not set
# CONFIG_FSCACHE_DEBUG is not set
# CONFIG_FSCACHE_OBJECT_LIST is not set
CONFIG_CACHEFILES=m
# CONFIG_CACHEFILES_DEBUG is not set
# CONFIG_CACHEFILES_HISTOGRAM is not set
# end of Caches

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_UDF_FS=m
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="ascii"
# CONFIG_FAT_DEFAULT_UTF8 is not set
# CONFIG_NTFS_FS is not set
# end of DOS/FAT/NT Filesystems

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_VMCORE=y
# CONFIG_PROC_VMCORE_DEVICE_DUMP is not set
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_PROC_PID_ARCH_STATUS=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_TMPFS_XATTR=y
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_MEMFD_CREATE=y
CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
CONFIG_CONFIGFS_FS=y
CONFIG_EFIVAR_FS=y
# end of Pseudo filesystems

CONFIG_MISC_FILESYSTEMS=y
# CONFIG_ORANGEFS_FS is not set
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_ECRYPT_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_JFFS2_FS is not set
# CONFIG_UBIFS_FS is not set
CONFIG_CRAMFS=m
CONFIG_CRAMFS_BLOCKDEV=y
# CONFIG_CRAMFS_MTD is not set
CONFIG_SQUASHFS=m
CONFIG_SQUASHFS_FILE_CACHE=y
# CONFIG_SQUASHFS_FILE_DIRECT is not set
CONFIG_SQUASHFS_DECOMP_SINGLE=y
# CONFIG_SQUASHFS_DECOMP_MULTI is not set
# CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU is not set
CONFIG_SQUASHFS_XATTR=y
CONFIG_SQUASHFS_ZLIB=y
# CONFIG_SQUASHFS_LZ4 is not set
CONFIG_SQUASHFS_LZO=y
CONFIG_SQUASHFS_XZ=y
# CONFIG_SQUASHFS_ZSTD is not set
# CONFIG_SQUASHFS_4K_DEVBLK_SIZE is not set
# CONFIG_SQUASHFS_EMBEDDED is not set
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
# CONFIG_VXFS_FS is not set
CONFIG_MINIX_FS=m
# CONFIG_OMFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX6FS_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_PSTORE=y
CONFIG_PSTORE_DEFLATE_COMPRESS=y
# CONFIG_PSTORE_LZO_COMPRESS is not set
# CONFIG_PSTORE_LZ4_COMPRESS is not set
# CONFIG_PSTORE_LZ4HC_COMPRESS is not set
# CONFIG_PSTORE_842_COMPRESS is not set
# CONFIG_PSTORE_ZSTD_COMPRESS is not set
CONFIG_PSTORE_COMPRESS=y
CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT=y
CONFIG_PSTORE_COMPRESS_DEFAULT="deflate"
CONFIG_PSTORE_CONSOLE=y
CONFIG_PSTORE_PMSG=y
# CONFIG_PSTORE_FTRACE is not set
CONFIG_PSTORE_RAM=m
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set
# CONFIG_EROFS_FS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
# CONFIG_NFS_V2 is not set
CONFIG_NFS_V3=y
CONFIG_NFS_V3_ACL=y
CONFIG_NFS_V4=m
# CONFIG_NFS_SWAP is not set
CONFIG_NFS_V4_1=y
CONFIG_NFS_V4_2=y
CONFIG_PNFS_FILE_LAYOUT=m
CONFIG_PNFS_BLOCK=m
CONFIG_PNFS_FLEXFILE_LAYOUT=m
CONFIG_NFS_V4_1_IMPLEMENTATION_ID_DOMAIN="kernel.org"
# CONFIG_NFS_V4_1_MIGRATION is not set
CONFIG_NFS_V4_SECURITY_LABEL=y
CONFIG_ROOT_NFS=y
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
CONFIG_NFS_DEBUG=y
CONFIG_NFSD=m
CONFIG_NFSD_V2_ACL=y
CONFIG_NFSD_V3=y
CONFIG_NFSD_V3_ACL=y
CONFIG_NFSD_V4=y
CONFIG_NFSD_PNFS=y
# CONFIG_NFSD_BLOCKLAYOUT is not set
CONFIG_NFSD_SCSILAYOUT=y
# CONFIG_NFSD_FLEXFILELAYOUT is not set
CONFIG_NFSD_V4_SECURITY_LABEL=y
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_ACL_SUPPORT=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=m
CONFIG_SUNRPC_BACKCHANNEL=y
CONFIG_RPCSEC_GSS_KRB5=m
# CONFIG_SUNRPC_DISABLE_INSECURE_ENCTYPES is not set
CONFIG_SUNRPC_DEBUG=y
CONFIG_CEPH_FS=m
# CONFIG_CEPH_FSCACHE is not set
CONFIG_CEPH_FS_POSIX_ACL=y
# CONFIG_CEPH_FS_SECURITY_LABEL is not set
CONFIG_CIFS=m
# CONFIG_CIFS_STATS2 is not set
CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
CONFIG_CIFS_WEAK_PW_HASH=y
CONFIG_CIFS_UPCALL=y
CONFIG_CIFS_XATTR=y
CONFIG_CIFS_POSIX=y
CONFIG_CIFS_DEBUG=y
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
CONFIG_CIFS_DFS_UPCALL=y
# CONFIG_CIFS_FSCACHE is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
CONFIG_9P_FS=y
CONFIG_9P_FS_POSIX_ACL=y
# CONFIG_9P_FS_SECURITY is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="utf8"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=m
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=m
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_MAC_ROMAN=m
CONFIG_NLS_MAC_CELTIC=m
CONFIG_NLS_MAC_CENTEURO=m
CONFIG_NLS_MAC_CROATIAN=m
CONFIG_NLS_MAC_CYRILLIC=m
CONFIG_NLS_MAC_GAELIC=m
CONFIG_NLS_MAC_GREEK=m
CONFIG_NLS_MAC_ICELAND=m
CONFIG_NLS_MAC_INUIT=m
CONFIG_NLS_MAC_ROMANIAN=m
CONFIG_NLS_MAC_TURKISH=m
CONFIG_NLS_UTF8=m
CONFIG_DLM=m
CONFIG_DLM_DEBUG=y
# CONFIG_UNICODE is not set
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
CONFIG_KEYS_COMPAT=y
# CONFIG_KEYS_REQUEST_CACHE is not set
CONFIG_PERSISTENT_KEYRINGS=y
CONFIG_BIG_KEYS=y
CONFIG_TRUSTED_KEYS=y
CONFIG_ENCRYPTED_KEYS=y
# CONFIG_KEY_DH_OPERATIONS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=y
CONFIG_SECURITY_WRITABLE_HOOKS=y
CONFIG_SECURITYFS=y
CONFIG_SECURITY_NETWORK=y
CONFIG_PAGE_TABLE_ISOLATION=y
CONFIG_SECURITY_NETWORK_XFRM=y
CONFIG_SECURITY_PATH=y
CONFIG_INTEL_TXT=y
CONFIG_LSM_MMAP_MIN_ADDR=65535
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HARDENED_USERCOPY=y
CONFIG_HARDENED_USERCOPY_FALLBACK=y
# CONFIG_HARDENED_USERCOPY_PAGESPAN is not set
# CONFIG_FORTIFY_SOURCE is not set
# CONFIG_STATIC_USERMODEHELPER is not set
CONFIG_SECURITY_SELINUX=y
CONFIG_SECURITY_SELINUX_BOOTPARAM=y
CONFIG_SECURITY_SELINUX_DISABLE=y
CONFIG_SECURITY_SELINUX_DEVELOP=y
CONFIG_SECURITY_SELINUX_AVC_STATS=y
CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE=1
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
CONFIG_SECURITY_APPARMOR=y
CONFIG_SECURITY_APPARMOR_HASH=y
CONFIG_SECURITY_APPARMOR_HASH_DEFAULT=y
# CONFIG_SECURITY_APPARMOR_DEBUG is not set
# CONFIG_SECURITY_LOADPIN is not set
CONFIG_SECURITY_YAMA=y
# CONFIG_SECURITY_SAFESETID is not set
# CONFIG_SECURITY_LOCKDOWN_LSM is not set
CONFIG_INTEGRITY=y
CONFIG_INTEGRITY_SIGNATURE=y
CONFIG_INTEGRITY_ASYMMETRIC_KEYS=y
CONFIG_INTEGRITY_TRUSTED_KEYRING=y
# CONFIG_INTEGRITY_PLATFORM_KEYRING is not set
CONFIG_INTEGRITY_AUDIT=y
CONFIG_IMA=y
CONFIG_IMA_MEASURE_PCR_IDX=10
CONFIG_IMA_LSM_RULES=y
# CONFIG_IMA_TEMPLATE is not set
CONFIG_IMA_NG_TEMPLATE=y
# CONFIG_IMA_SIG_TEMPLATE is not set
CONFIG_IMA_DEFAULT_TEMPLATE="ima-ng"
CONFIG_IMA_DEFAULT_HASH_SHA1=y
# CONFIG_IMA_DEFAULT_HASH_SHA256 is not set
# CONFIG_IMA_DEFAULT_HASH_SHA512 is not set
CONFIG_IMA_DEFAULT_HASH="sha1"
# CONFIG_IMA_WRITE_POLICY is not set
# CONFIG_IMA_READ_POLICY is not set
CONFIG_IMA_APPRAISE=y
# CONFIG_IMA_ARCH_POLICY is not set
# CONFIG_IMA_APPRAISE_BUILD_POLICY is not set
CONFIG_IMA_APPRAISE_BOOTPARAM=y
# CONFIG_IMA_APPRAISE_MODSIG is not set
CONFIG_IMA_TRUSTED_KEYRING=y
# CONFIG_IMA_BLACKLIST_KEYRING is not set
# CONFIG_IMA_LOAD_X509 is not set
CONFIG_EVM=y
CONFIG_EVM_ATTR_FSUUID=y
# CONFIG_EVM_ADD_XATTRS is not set
# CONFIG_EVM_LOAD_X509 is not set
CONFIG_DEFAULT_SECURITY_SELINUX=y
# CONFIG_DEFAULT_SECURITY_APPARMOR is not set
# CONFIG_DEFAULT_SECURITY_DAC is not set
CONFIG_LSM="lockdown,yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_INIT_STACK_NONE=y
# CONFIG_GCC_PLUGIN_STRUCTLEAK_USER is not set
# CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF is not set
# CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL is not set
# CONFIG_GCC_PLUGIN_STACKLEAK is not set
# CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not set
# CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
# end of Memory initialization
# end of Kernel hardening options
# end of Security options

CONFIG_XOR_BLOCKS=m
CONFIG_ASYNC_CORE=m
CONFIG_ASYNC_MEMCPY=m
CONFIG_ASYNC_XOR=m
CONFIG_ASYNC_PQ=m
CONFIG_ASYNC_RAID6_RECOV=m
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_BLKCIPHER=y
CONFIG_CRYPTO_BLKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_KPP=m
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
CONFIG_CRYPTO_USER=m
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_PCRYPT=m
CONFIG_CRYPTO_CRYPTD=m
CONFIG_CRYPTO_AUTHENC=m
CONFIG_CRYPTO_TEST=m
CONFIG_CRYPTO_SIMD=m
CONFIG_CRYPTO_GLUE_HELPER_X86=m
CONFIG_CRYPTO_ENGINE=m

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=m
CONFIG_CRYPTO_ECC=m
CONFIG_CRYPTO_ECDH=m
# CONFIG_CRYPTO_ECRDSA is not set

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=m
CONFIG_CRYPTO_GCM=y
# CONFIG_CRYPTO_CHACHA20POLY1305 is not set
# CONFIG_CRYPTO_AEGIS128 is not set
# CONFIG_CRYPTO_AEGIS128_AESNI_SSE2 is not set
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=m

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
# CONFIG_CRYPTO_CFB is not set
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=y
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=m
# CONFIG_CRYPTO_OFB is not set
CONFIG_CRYPTO_PCBC=m
CONFIG_CRYPTO_XTS=y
# CONFIG_CRYPTO_KEYWRAP is not set
# CONFIG_CRYPTO_NHPOLY1305_SSE2 is not set
# CONFIG_CRYPTO_NHPOLY1305_AVX2 is not set
# CONFIG_CRYPTO_ADIANTUM is not set
CONFIG_CRYPTO_ESSIV=m

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=m
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_XCBC=m
CONFIG_CRYPTO_VMAC=m

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32C_INTEL=m
CONFIG_CRYPTO_CRC32=m
CONFIG_CRYPTO_CRC32_PCLMUL=m
# CONFIG_CRYPTO_XXHASH is not set
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_CRCT10DIF_PCLMUL=m
CONFIG_CRYPTO_GHASH=y
# CONFIG_CRYPTO_POLY1305 is not set
# CONFIG_CRYPTO_POLY1305_X86_64 is not set
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=m
CONFIG_CRYPTO_RMD128=m
CONFIG_CRYPTO_RMD160=m
CONFIG_CRYPTO_RMD256=m
CONFIG_CRYPTO_RMD320=m
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA1_SSSE3=y
CONFIG_CRYPTO_SHA256_SSSE3=y
CONFIG_CRYPTO_SHA512_SSSE3=m
CONFIG_CRYPTO_LIB_SHA256=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
# CONFIG_CRYPTO_SHA3 is not set
# CONFIG_CRYPTO_SM3 is not set
# CONFIG_CRYPTO_STREEBOG is not set
CONFIG_CRYPTO_TGR192=m
CONFIG_CRYPTO_WP512=m
CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=m

#
# Ciphers
#
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
CONFIG_CRYPTO_AES_NI_INTEL=m
CONFIG_CRYPTO_ANUBIS=m
CONFIG_CRYPTO_LIB_ARC4=m
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_BLOWFISH_COMMON=m
CONFIG_CRYPTO_BLOWFISH_X86_64=m
CONFIG_CRYPTO_CAMELLIA=m
CONFIG_CRYPTO_CAMELLIA_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=m
CONFIG_CRYPTO_CAST_COMMON=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST5_AVX_X86_64=m
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_CAST6_AVX_X86_64=m
CONFIG_CRYPTO_LIB_DES=m
CONFIG_CRYPTO_DES=m
# CONFIG_CRYPTO_DES3_EDE_X86_64 is not set
CONFIG_CRYPTO_FCRYPT=m
CONFIG_CRYPTO_KHAZAD=m
CONFIG_CRYPTO_SALSA20=m
# CONFIG_CRYPTO_CHACHA20 is not set
# CONFIG_CRYPTO_CHACHA20_X86_64 is not set
CONFIG_CRYPTO_SEED=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_SERPENT_SSE2_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX2_X86_64=m
# CONFIG_CRYPTO_SM4 is not set
CONFIG_CRYPTO_TEA=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_TWOFISH_COMMON=m
CONFIG_CRYPTO_TWOFISH_X86_64=m
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=m
CONFIG_CRYPTO_TWOFISH_AVX_X86_64=m

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
# CONFIG_CRYPTO_842 is not set
# CONFIG_CRYPTO_LZ4 is not set
# CONFIG_CRYPTO_LZ4HC is not set
# CONFIG_CRYPTO_ZSTD is not set

#
# Random Number Generation
#
CONFIG_CRYPTO_ANSI_CPRNG=m
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
CONFIG_CRYPTO_DRBG_HASH=y
CONFIG_CRYPTO_DRBG_CTR=y
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
CONFIG_CRYPTO_USER_API=y
CONFIG_CRYPTO_USER_API_HASH=y
CONFIG_CRYPTO_USER_API_SKCIPHER=y
CONFIG_CRYPTO_USER_API_RNG=m
# CONFIG_CRYPTO_USER_API_AEAD is not set
# CONFIG_CRYPTO_STATS is not set
CONFIG_CRYPTO_HASH_INFO=y
CONFIG_CRYPTO_HW=y
CONFIG_CRYPTO_DEV_PADLOCK=m
CONFIG_CRYPTO_DEV_PADLOCK_AES=m
CONFIG_CRYPTO_DEV_PADLOCK_SHA=m
# CONFIG_CRYPTO_DEV_ATMEL_ECC is not set
# CONFIG_CRYPTO_DEV_ATMEL_SHA204A is not set
CONFIG_CRYPTO_DEV_CCP=y
CONFIG_CRYPTO_DEV_CCP_DD=m
CONFIG_CRYPTO_DEV_SP_CCP=y
CONFIG_CRYPTO_DEV_CCP_CRYPTO=m
CONFIG_CRYPTO_DEV_SP_PSP=y
# CONFIG_CRYPTO_DEV_CCP_DEBUGFS is not set
CONFIG_CRYPTO_DEV_QAT=m
CONFIG_CRYPTO_DEV_QAT_DH895xCC=m
CONFIG_CRYPTO_DEV_QAT_C3XXX=m
CONFIG_CRYPTO_DEV_QAT_C62X=m
CONFIG_CRYPTO_DEV_QAT_DH895xCCVF=m
CONFIG_CRYPTO_DEV_QAT_C3XXXVF=m
CONFIG_CRYPTO_DEV_QAT_C62XVF=m
# CONFIG_CRYPTO_DEV_NITROX_CNN55XX is not set
CONFIG_CRYPTO_DEV_CHELSIO=m
CONFIG_CRYPTO_DEV_VIRTIO=m
# CONFIG_CRYPTO_DEV_SAFEXCEL is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
# CONFIG_ASYMMETRIC_TPM_KEY_SUBTYPE is not set
CONFIG_X509_CERTIFICATE_PARSER=y
# CONFIG_PKCS8_PRIVATE_KEY_PARSER is not set
CONFIG_PKCS7_MESSAGE_PARSER=y
# CONFIG_PKCS7_TEST_KEY is not set
CONFIG_SIGNED_PE_FILE_VERIFICATION=y

#
# Certificates for signature checking
#
CONFIG_MODULE_SIG_KEY="certs/signing_key.pem"
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
# CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
# CONFIG_SECONDARY_TRUSTED_KEYRING is not set
CONFIG_SYSTEM_BLACKLIST_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_RAID6_PQ=m
CONFIG_RAID6_PQ_BENCHMARK=y
# CONFIG_PACKING is not set
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_GENERIC_FIND_FIRST_BIT=y
CONFIG_CORDIC=m
CONFIG_PRIME_NUMBERS=m
CONFIG_RATIONAL=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC_ITU_T=m
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
# CONFIG_CRC64 is not set
# CONFIG_CRC4 is not set
# CONFIG_CRC7 is not set
CONFIG_LIBCRC32C=m
CONFIG_CRC8=m
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMPRESS=m
CONFIG_ZSTD_DECOMPRESS=m
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_IA64=y
CONFIG_XZ_DEC_ARM=y
CONFIG_XZ_DEC_ARMTHUMB=y
CONFIG_XZ_DEC_SPARC=y
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=m
CONFIG_REED_SOLOMON_ENC8=y
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_TEXTSEARCH=y
CONFIG_TEXTSEARCH_KMP=m
CONFIG_TEXTSEARCH_BM=m
CONFIG_TEXTSEARCH_FSM=m
CONFIG_BTREE=y
CONFIG_INTERVAL_TREE=y
CONFIG_XARRAY_MULTI=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_ARCH_HAS_FORCE_DMA_UNENCRYPTED=y
CONFIG_SWIOTLB=y
CONFIG_DMA_CMA=y

#
# Default contiguous memory area size:
#
CONFIG_CMA_SIZE_MBYTES=200
CONFIG_CMA_SIZE_SEL_MBYTES=y
# CONFIG_CMA_SIZE_SEL_PERCENTAGE is not set
# CONFIG_CMA_SIZE_SEL_MIN is not set
# CONFIG_CMA_SIZE_SEL_MAX is not set
CONFIG_CMA_ALIGNMENT=8
# CONFIG_DMA_API_DEBUG is not set
CONFIG_SGL_ALLOC=y
CONFIG_IOMMU_HELPER=y
CONFIG_CHECK_SIGNATURE=y
CONFIG_CPUMASK_OFFSTACK=y
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_SIGNATURE=y
CONFIG_DIMLIB=y
CONFIG_OID_REGISTRY=y
CONFIG_UCS2_STRING=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_FONT_SUPPORT=y
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_ARCH_HAS_UACCESS_MCSAFE=y
CONFIG_ARCH_STACKWALK=y
CONFIG_SBITMAP=y
# CONFIG_STRING_SELFTEST is not set
# end of Library routines

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
# CONFIG_PRINTK_CALLER is not set
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
CONFIG_BOOT_PRINTK_DELAY=y
CONFIG_DYNAMIC_DEBUG=y
# end of printk and dmesg options

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
CONFIG_DEBUG_INFO_REDUCED=y
# CONFIG_DEBUG_INFO_SPLIT is not set
# CONFIG_DEBUG_INFO_DWARF4 is not set
# CONFIG_DEBUG_INFO_BTF is not set
# CONFIG_GDB_SCRIPTS is not set
CONFIG_ENABLE_MUST_CHECK=y
CONFIG_FRAME_WARN=2048
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_READABLE_ASM is not set
CONFIG_DEBUG_FS=y
# CONFIG_HEADERS_INSTALL is not set
CONFIG_OPTIMIZE_INLINING=y
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_STACK_VALIDATION=y
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
# end of Compile-time checks and compiler options

CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_MISC=y

#
# Memory Debugging
#
# CONFIG_PAGE_EXTENSION is not set
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_PAGE_OWNER is not set
# CONFIG_PAGE_POISONING is not set
# CONFIG_DEBUG_PAGE_REF is not set
CONFIG_DEBUG_RODATA_TEST=y
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_SLUB_DEBUG_ON is not set
# CONFIG_SLUB_STATS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_DEBUG_VM is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
CONFIG_MEMORY_NOTIFIER_ERROR_INJECT=m
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_CC_HAS_KASAN_GENERIC=y
# CONFIG_KASAN is not set
CONFIG_KASAN_STACK=1
# end of Memory Debugging

CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_KCOV is not set
CONFIG_DEBUG_SHIRQ=y

#
# Debug Lockups and Hangs
#
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=0
CONFIG_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
CONFIG_HARDLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=1
# CONFIG_DETECT_HUNG_TASK is not set
# CONFIG_WQ_WATCHDOG is not set
# end of Debug Lockups and Hangs

CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
# CONFIG_SCHED_STACK_END_CHECK is not set
# CONFIG_DEBUG_TIMEKEEPING is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
# CONFIG_PROVE_LOCKING is not set
# CONFIG_LOCK_STAT is not set
# CONFIG_DEBUG_RT_MUTEXES is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_MUTEXES is not set
# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
# CONFIG_DEBUG_RWSEMS is not set
# CONFIG_DEBUG_LOCK_ALLOC is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
CONFIG_LOCK_TORTURE_TEST=m
CONFIG_WW_MUTEX_SELFTEST=m
# end of Lock Debugging (spinlocks, mutexes, etc...)

CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_BUGVERBOSE=y
CONFIG_DEBUG_LIST=y
# CONFIG_DEBUG_PLIST is not set
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
CONFIG_TORTURE_TEST=m
CONFIG_RCU_PERF_TEST=m
CONFIG_RCU_TORTURE_TEST=m
CONFIG_RCU_CPU_STALL_TIMEOUT=60
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging

# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
CONFIG_NOTIFIER_ERROR_INJECTION=m
CONFIG_PM_NOTIFIER_ERROR_INJECT=m
# CONFIG_NETDEV_NOTIFIER_ERROR_INJECT is not set
CONFIG_FUNCTION_ERROR_INJECTION=y
CONFIG_FAULT_INJECTION=y
# CONFIG_FAILSLAB is not set
# CONFIG_FAIL_PAGE_ALLOC is not set
CONFIG_FAIL_MAKE_REQUEST=y
# CONFIG_FAIL_IO_TIMEOUT is not set
# CONFIG_FAIL_FUTEX is not set
CONFIG_FAULT_INJECTION_DEBUG_FS=y
# CONFIG_FAIL_FUNCTION is not set
# CONFIG_FAIL_MMC_REQUEST is not set
CONFIG_LATENCYTOP=y
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_TRACER_MAX_TRACE=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_RING_BUFFER_ALLOW_SWAP=y
CONFIG_TRACING=y
CONFIG_GENERIC_TRACER=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
CONFIG_FUNCTION_TRACER=y
CONFIG_FUNCTION_GRAPH_TRACER=y
# CONFIG_PREEMPTIRQ_EVENTS is not set
# CONFIG_IRQSOFF_TRACER is not set
CONFIG_SCHED_TRACER=y
CONFIG_HWLAT_TRACER=y
CONFIG_FTRACE_SYSCALLS=y
CONFIG_TRACER_SNAPSHOT=y
# CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP is not set
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
# CONFIG_PROFILE_ALL_BRANCHES is not set
CONFIG_STACK_TRACER=y
CONFIG_BLK_DEV_IO_TRACE=y
CONFIG_KPROBE_EVENTS=y
# CONFIG_KPROBE_EVENTS_ON_NOTRACE is not set
CONFIG_UPROBE_EVENTS=y
CONFIG_BPF_EVENTS=y
CONFIG_DYNAMIC_EVENTS=y
CONFIG_PROBE_EVENTS=y
CONFIG_DYNAMIC_FTRACE=y
CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_FUNCTION_PROFILER=y
# CONFIG_BPF_KPROBE_OVERRIDE is not set
CONFIG_FTRACE_MCOUNT_RECORD=y
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_MMIOTRACE is not set
CONFIG_TRACING_MAP=y
CONFIG_HIST_TRIGGERS=y
# CONFIG_TRACEPOINT_BENCHMARK is not set
CONFIG_RING_BUFFER_BENCHMARK=m
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_PREEMPTIRQ_DELAY_TEST is not set
# CONFIG_TRACE_EVAL_MAP_FILE is not set
CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
CONFIG_RUNTIME_TESTING_MENU=y
# CONFIG_LKDTM is not set
# CONFIG_TEST_LIST_SORT is not set
# CONFIG_TEST_SORT is not set
# CONFIG_KPROBES_SANITY_TEST is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_RBTREE_TEST is not set
# CONFIG_REED_SOLOMON_TEST is not set
# CONFIG_INTERVAL_TREE_TEST is not set
# CONFIG_PERCPU_TEST is not set
CONFIG_ATOMIC64_SELFTEST=y
# CONFIG_ASYNC_RAID6_TEST is not set
# CONFIG_TEST_HEXDUMP is not set
# CONFIG_TEST_STRING_HELPERS is not set
CONFIG_TEST_STRSCPY=m
# CONFIG_TEST_KSTRTOX is not set
CONFIG_TEST_PRINTF=m
CONFIG_TEST_BITMAP=m
# CONFIG_TEST_BITFIELD is not set
# CONFIG_TEST_UUID is not set
# CONFIG_TEST_XARRAY is not set
# CONFIG_TEST_OVERFLOW is not set
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_TEST_HASH is not set
# CONFIG_TEST_IDA is not set
CONFIG_TEST_LKM=m
CONFIG_TEST_VMALLOC=m
CONFIG_TEST_USER_COPY=m
CONFIG_TEST_BPF=m
CONFIG_TEST_BLACKHOLE_DEV=m
# CONFIG_FIND_BIT_BENCHMARK is not set
CONFIG_TEST_FIRMWARE=m
CONFIG_TEST_SYSCTL=m
# CONFIG_TEST_UDELAY is not set
CONFIG_TEST_STATIC_KEYS=m
CONFIG_TEST_KMOD=m
# CONFIG_TEST_MEMCAT_P is not set
CONFIG_TEST_LIVEPATCH=m
# CONFIG_TEST_STACKINIT is not set
# CONFIG_TEST_MEMINIT is not set
# CONFIG_MEMTEST is not set
# CONFIG_BUG_ON_DATA_CORRUPTION is not set
# CONFIG_SAMPLES is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
# CONFIG_UBSAN is not set
CONFIG_UBSAN_ALIGNMENT=y
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_STRICT_DEVMEM=y
# CONFIG_IO_STRICT_DEVMEM is not set
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_EARLY_PRINTK_USB=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
CONFIG_EARLY_PRINTK_DBGP=y
# CONFIG_EARLY_PRINTK_USB_XDBC is not set
# CONFIG_X86_PTDUMP is not set
# CONFIG_EFI_PGT_DUMP is not set
# CONFIG_DEBUG_WX is not set
CONFIG_DOUBLEFAULT=y
# CONFIG_DEBUG_TLBFLUSH is not set
# CONFIG_IOMMU_DEBUG is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
CONFIG_X86_DECODER_SELFTEST=y
CONFIG_IO_DELAY_0X80=y
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEBUG_BOOT_PARAMS=y
# CONFIG_CPA_DEBUG is not set
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
CONFIG_X86_DEBUG_FPU=y
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_ORC=y
# CONFIG_UNWINDER_FRAME_POINTER is not set
# CONFIG_UNWINDER_GUESS is not set
# end of Kernel hacking

--GBuTPvBEOL0MYPgd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=job-script

#!/bin/sh

export_top_env()
{
	export suite='fio-basic'
	export testcase='fio-basic'
	export category='benchmark'
	export runtime=200
	export nr_task=48
	export time_based='tb'
	export job_origin='/lkp/lkp/.src-20191018-224157/allot/cyclic:p1:linux-devel:devel-hourly/lkp-csl-2sp6/fio-basic-2pmem-dax-256G.yaml'
	export queue_cmdline_keys='branch
commit
queue_at_least_once'
	export queue='validate'
	export testbox='lkp-csl-2sp6'
	export tbox_group='lkp-csl-2sp6'
	export submit_id='5db3fb0d21820c1ef3f0fc66'
	export job_file='/lkp/jobs/scheduled/lkp-csl-2sp6/fio-basic-4k-performance-2pmem-ext4-mmap-dax-50%-200s-rw-200G-tb--20191026-7923-zlkw6q-3.yaml'
	export id='74d4a4951867328040f6ed8d98c5fa547f44b825'
	export queuer_version='/lkp-src'
	export arch='x86_64'
	export model='Cascade Lake'
	export nr_node=2
	export nr_cpu=96
	export memory='256G'
	export nr_hdd_partitions=1
	export hdd_partitions='/dev/disk/by-id/ata-WDC_WD10EZEX-75ZF5A0_WD-WCC1S1302268-part5'
	export ssd_partitions='/dev/disk/by-id/ata-INTEL_SSDSC2BB800G4_PHWL4204001B800RGN-part1'
	export swap_partitions=
	export rootfs_partition='/dev/disk/by-id/ata-WDC_WD10EZEX-75ZF5A0_WD-WCC1S1302268-part4'
	export brand='Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz'
	export ucode='0x5000021'
	export need_kconfig='CONFIG_LIBNVDIMM
CONFIG_BTT
CONFIG_BLK_DEV_PMEM
CONFIG_X86_PMEM_LEGACY
CONFIG_EXT4_FS'
	export commit='a70e8083a91b17a7c77012f7746dbf29b5050e66'
	export need_kconfig_hw='CONFIG_I40E=y'
	export kconfig='x86_64-rhel-7.6'
	export compiler='gcc-7'
	export rootfs='debian-x86_64-2019-05-14.cgz'
	export enqueue_time='2019-10-26 15:53:09 +0800'
	export _id='5db3fb6821820c1ef3f0fc67'
	export _rt='/result/fio-basic/4k-performance-2pmem-ext4-mmap-dax-50%-200s-rw-200G-tb-ucode=0x5000021/lkp-csl-2sp6/debian-x86_64-2019-05-14.cgz/x86_64-rhel-7.6/gcc-7/a70e8083a91b17a7c77012f7746dbf29b5050e66'
	export user='lkp'
	export head_commit='2663e4fbd8a09ca6f88a34752863f0924e2af46e'
	export base_commit='7d194c2100ad2a6dded545887d02754948ca5241'
	export branch='linux-devel/devel-hourly-2019102219'
	export result_root='/result/fio-basic/4k-performance-2pmem-ext4-mmap-dax-50%-200s-rw-200G-tb-ucode=0x5000021/lkp-csl-2sp6/debian-x86_64-2019-05-14.cgz/x86_64-rhel-7.6/gcc-7/a70e8083a91b17a7c77012f7746dbf29b5050e66/3'
	export scheduler_version='/lkp/lkp/.src-20191025-221333'
	export LKP_SERVER='inn'
	export max_uptime=1200
	export initrd='/osimage/debian/debian-x86_64-2019-05-14.cgz'
	export bootloader_append='root=/dev/ram0
user=lkp
job=/lkp/jobs/scheduled/lkp-csl-2sp6/fio-basic-4k-performance-2pmem-ext4-mmap-dax-50%-200s-rw-200G-tb--20191026-7923-zlkw6q-3.yaml
ARCH=x86_64
kconfig=x86_64-rhel-7.6
branch=linux-devel/devel-hourly-2019102219
commit=a70e8083a91b17a7c77012f7746dbf29b5050e66
BOOT_IMAGE=/pkg/linux/x86_64-rhel-7.6/gcc-7/a70e8083a91b17a7c77012f7746dbf29b5050e66/vmlinuz-5.4.0-rc4-00001-ga70e8083a91b1
memmap=104G!8G
memmap=104G!132G
max_uptime=1200
RESULT_ROOT=/result/fio-basic/4k-performance-2pmem-ext4-mmap-dax-50%-200s-rw-200G-tb-ucode=0x5000021/lkp-csl-2sp6/debian-x86_64-2019-05-14.cgz/x86_64-rhel-7.6/gcc-7/a70e8083a91b17a7c77012f7746dbf29b5050e66/3
LKP_SERVER=inn
nokaslr
debug
apic=debug
sysrq_always_enabled
rcupdate.rcu_cpu_stall_timeout=100
net.ifnames=0
printk.devkmsg=on
panic=-1
softlockup_panic=1
nmi_watchdog=panic
oops=panic
load_ramdisk=2
prompt_ramdisk=0
drbd.minor_count=8
systemd.log_level=err
ignore_loglevel
console=tty0
earlyprintk=ttyS0,115200
console=ttyS0,115200
vga=normal
rw'
	export modules_initrd='/pkg/linux/x86_64-rhel-7.6/gcc-7/a70e8083a91b17a7c77012f7746dbf29b5050e66/modules.cgz'
	export bm_initrd='/osimage/deps/debian-x86_64-2018-04-03.cgz/run-ipconfig_2018-04-03.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/lkp_2019-08-05.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/rsync-rootfs_2018-04-03.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/fs_2019-10-10.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/fio_2019-09-30.cgz,/osimage/pkg/debian-x86_64-2018-04-03.cgz/fio-x86_64-3.15-1_2019-10-10.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/mpstat_2019-10-10.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/vmstat_2019-10-11.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/turbostat_2019-10-11.cgz,/osimage/pkg/debian-x86_64-2018-04-03.cgz/turbostat-x86_64-3.7-4_2019-10-11.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/perf_2019-10-10.cgz,/osimage/pkg/debian-x86_64-2018-04-03.cgz/perf-x86_64-bc88f85c6c09_2019-10-17.cgz,/osimage/pkg/debian-x86_64-2018-04-03.cgz/sar-x86_64-c582fe4-1_2019-10-10.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/hw_2019-10-09.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export repeat_to=4
	export schedule_notify_address=
	export queue_at_least_once=1
	export kernel='/pkg/linux/x86_64-rhel-7.6/gcc-7/a70e8083a91b17a7c77012f7746dbf29b5050e66/vmlinuz-5.4.0-rc4-00001-ga70e8083a91b1'
	export dequeue_time='2019-10-26 16:03:48 +0800'
	export job_initrd='/lkp/jobs/scheduled/lkp-csl-2sp6/fio-basic-4k-performance-2pmem-ext4-mmap-dax-50%-200s-rw-200G-tb--20191026-7923-zlkw6q-3.cgz'

	[ -n "$LKP_SRC" ] ||
	export LKP_SRC=/lkp/${user:-lkp}/src
}

run_job()
{
	echo $$ > $TMP/run-job.pid

	. $LKP_SRC/lib/http.sh
	. $LKP_SRC/lib/job.sh
	. $LKP_SRC/lib/env.sh

	export_top_env

	run_setup bp1_memmap='104G!8G' bp2_memmap='104G!132G' $LKP_SRC/setup/boot_params

	run_setup nr_pmem=2 $LKP_SRC/setup/disk

	run_setup fs='ext4' mount_option='dax' $LKP_SRC/setup/fs

	run_setup rw='rw' bs='4k' ioengine='mmap' test_size='200G' $LKP_SRC/setup/fio-setup-basic

	run_setup $LKP_SRC/setup/cpufreq_governor 'performance'

	run_monitor $LKP_SRC/monitors/wrapper kmsg
	run_monitor $LKP_SRC/monitors/no-stdout/wrapper boot-time
	run_monitor $LKP_SRC/monitors/wrapper iostat
	run_monitor $LKP_SRC/monitors/wrapper heartbeat
	run_monitor $LKP_SRC/monitors/wrapper vmstat
	run_monitor $LKP_SRC/monitors/wrapper numa-numastat
	run_monitor $LKP_SRC/monitors/wrapper numa-vmstat
	run_monitor $LKP_SRC/monitors/wrapper numa-meminfo
	run_monitor $LKP_SRC/monitors/wrapper proc-vmstat
	run_monitor $LKP_SRC/monitors/wrapper proc-stat
	run_monitor $LKP_SRC/monitors/wrapper meminfo
	run_monitor $LKP_SRC/monitors/wrapper slabinfo
	run_monitor $LKP_SRC/monitors/wrapper interrupts
	run_monitor $LKP_SRC/monitors/wrapper lock_stat
	run_monitor $LKP_SRC/monitors/wrapper latency_stats
	run_monitor $LKP_SRC/monitors/wrapper softirqs
	run_monitor $LKP_SRC/monitors/one-shot/wrapper bdi_dev_mapping
	run_monitor $LKP_SRC/monitors/wrapper diskstats
	run_monitor $LKP_SRC/monitors/wrapper nfsstat
	run_monitor $LKP_SRC/monitors/wrapper cpuidle
	run_monitor $LKP_SRC/monitors/wrapper cpufreq-stats
	run_monitor $LKP_SRC/monitors/wrapper turbostat
	run_monitor $LKP_SRC/monitors/wrapper sched_debug
	run_monitor $LKP_SRC/monitors/wrapper perf-stat
	run_monitor $LKP_SRC/monitors/wrapper mpstat
	run_monitor $LKP_SRC/monitors/no-stdout/wrapper perf-profile
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test $LKP_SRC/tests/wrapper fio
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	$LKP_SRC/stats/wrapper fio
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper boot-time
	$LKP_SRC/stats/wrapper iostat
	$LKP_SRC/stats/wrapper vmstat
	$LKP_SRC/stats/wrapper numa-numastat
	$LKP_SRC/stats/wrapper numa-vmstat
	$LKP_SRC/stats/wrapper numa-meminfo
	$LKP_SRC/stats/wrapper proc-vmstat
	$LKP_SRC/stats/wrapper meminfo
	$LKP_SRC/stats/wrapper slabinfo
	$LKP_SRC/stats/wrapper interrupts
	$LKP_SRC/stats/wrapper lock_stat
	$LKP_SRC/stats/wrapper latency_stats
	$LKP_SRC/stats/wrapper softirqs
	$LKP_SRC/stats/wrapper diskstats
	$LKP_SRC/stats/wrapper nfsstat
	$LKP_SRC/stats/wrapper cpuidle
	$LKP_SRC/stats/wrapper turbostat
	$LKP_SRC/stats/wrapper sched_debug
	$LKP_SRC/stats/wrapper perf-stat
	$LKP_SRC/stats/wrapper mpstat
	$LKP_SRC/stats/wrapper perf-profile

	$LKP_SRC/stats/wrapper time fio.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--GBuTPvBEOL0MYPgd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="job.yaml"

---

#! jobs/fio-basic-2pmem-dax-256G.yaml
suite: fio-basic
testcase: fio-basic
category: benchmark
boot_params:
  bp1_memmap: 104G!8G
  bp2_memmap: 104G!132G
disk: 2pmem
fs:
  fs: ext4
  mount_option: dax
runtime: 200s
nr_task: 50%
time_based: tb
fio-setup-basic:
  rw: rw
  bs: 4k
  ioengine: mmap
  test_size: 200G
fio: 
job_origin: "/lkp/lkp/.src-20191018-224157/allot/cyclic:p1:linux-devel:devel-hourly/lkp-csl-2sp6/fio-basic-2pmem-dax-256G.yaml"

#! queue options
queue_cmdline_keys:
- branch
- commit
- queue_at_least_once
queue: bisect
testbox: lkp-csl-2sp6
tbox_group: lkp-csl-2sp6
submit_id: 5db3f50821820c1e62914ef7
job_file: "/lkp/jobs/scheduled/lkp-csl-2sp6/fio-basic-4k-performance-2pmem-ext4-mmap-dax-50%-200s-rw-200G-tb-uc-20191026-7778-u7e3so-0.yaml"
id: 40b11ae2f88c12563527522005a44c1bca791c50
queuer_version: "/lkp-src"
arch: x86_64

#! hosts/lkp-csl-2sp6
model: Cascade Lake
nr_node: 2
nr_cpu: 96
memory: 256G
nr_hdd_partitions: 1
hdd_partitions: "/dev/disk/by-id/ata-WDC_WD10EZEX-75ZF5A0_WD-WCC1S1302268-part5"
ssd_partitions: "/dev/disk/by-id/ata-INTEL_SSDSC2BB800G4_PHWL4204001B800RGN-part1"
swap_partitions: 
rootfs_partition: "/dev/disk/by-id/ata-WDC_WD10EZEX-75ZF5A0_WD-WCC1S1302268-part4"
brand: Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz
ucode: '0x5000021'

#! include/category/benchmark
kmsg: 
boot-time: 
iostat: 
heartbeat: 
vmstat: 
numa-numastat: 
numa-vmstat: 
numa-meminfo: 
proc-vmstat: 
proc-stat: 
meminfo: 
slabinfo: 
interrupts: 
lock_stat: 
latency_stats: 
softirqs: 
bdi_dev_mapping: 
diskstats: 
nfsstat: 
cpuidle: 
cpufreq-stats: 
turbostat: 
sched_debug: 
perf-stat: 
mpstat: 
perf-profile: 

#! include/category/ALL
cpufreq_governor: performance

#! include/disk/nr_pmem
need_kconfig:
- CONFIG_LIBNVDIMM
- CONFIG_BTT
- CONFIG_BLK_DEV_PMEM
- CONFIG_X86_PMEM_LEGACY
- CONFIG_EXT4_FS

#! include/queue/cyclic
commit: a70e8083a91b17a7c77012f7746dbf29b5050e66

#! include/testbox/lkp-csl-2sp6
need_kconfig_hw: CONFIG_I40E=y

#! include/fs/OTHERS

#! default params
kconfig: x86_64-rhel-7.6
compiler: gcc-7
rootfs: debian-x86_64-2019-05-14.cgz
enqueue_time: 2019-10-26 15:30:28.079462137 +08:00
_id: 5db3f50821820c1e62914ef7
_rt: "/result/fio-basic/4k-performance-2pmem-ext4-mmap-dax-50%-200s-rw-200G-tb-ucode=0x5000021/lkp-csl-2sp6/debian-x86_64-2019-05-14.cgz/x86_64-rhel-7.6/gcc-7/a70e8083a91b17a7c77012f7746dbf29b5050e66"

#! schedule options
user: lkp
head_commit: 2663e4fbd8a09ca6f88a34752863f0924e2af46e
base_commit: 7d194c2100ad2a6dded545887d02754948ca5241
branch: linux-devel/devel-hourly-2019102219
result_root: "/result/fio-basic/4k-performance-2pmem-ext4-mmap-dax-50%-200s-rw-200G-tb-ucode=0x5000021/lkp-csl-2sp6/debian-x86_64-2019-05-14.cgz/x86_64-rhel-7.6/gcc-7/a70e8083a91b17a7c77012f7746dbf29b5050e66/0"
scheduler_version: "/lkp/lkp/.src-20191025-221333"
LKP_SERVER: inn
max_uptime: 1200
initrd: "/osimage/debian/debian-x86_64-2019-05-14.cgz"
bootloader_append:
- root=/dev/ram0
- user=lkp
- job=/lkp/jobs/scheduled/lkp-csl-2sp6/fio-basic-4k-performance-2pmem-ext4-mmap-dax-50%-200s-rw-200G-tb-uc-20191026-7778-u7e3so-0.yaml
- ARCH=x86_64
- kconfig=x86_64-rhel-7.6
- branch=linux-devel/devel-hourly-2019102219
- commit=a70e8083a91b17a7c77012f7746dbf29b5050e66
- BOOT_IMAGE=/pkg/linux/x86_64-rhel-7.6/gcc-7/a70e8083a91b17a7c77012f7746dbf29b5050e66/vmlinuz-5.4.0-rc4-00001-ga70e8083a91b1
- memmap=104G!8G
- memmap=104G!132G
- max_uptime=1200
- RESULT_ROOT=/result/fio-basic/4k-performance-2pmem-ext4-mmap-dax-50%-200s-rw-200G-tb-ucode=0x5000021/lkp-csl-2sp6/debian-x86_64-2019-05-14.cgz/x86_64-rhel-7.6/gcc-7/a70e8083a91b17a7c77012f7746dbf29b5050e66/0
- LKP_SERVER=inn
- nokaslr
- debug
- apic=debug
- sysrq_always_enabled
- rcupdate.rcu_cpu_stall_timeout=100
- net.ifnames=0
- printk.devkmsg=on
- panic=-1
- softlockup_panic=1
- nmi_watchdog=panic
- oops=panic
- load_ramdisk=2
- prompt_ramdisk=0
- drbd.minor_count=8
- systemd.log_level=err
- ignore_loglevel
- console=tty0
- earlyprintk=ttyS0,115200
- console=ttyS0,115200
- vga=normal
- rw
modules_initrd: "/pkg/linux/x86_64-rhel-7.6/gcc-7/a70e8083a91b17a7c77012f7746dbf29b5050e66/modules.cgz"
bm_initrd: "/osimage/deps/debian-x86_64-2018-04-03.cgz/run-ipconfig_2018-04-03.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/lkp_2019-08-05.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/rsync-rootfs_2018-04-03.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/fs_2019-10-10.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/fio_2019-09-30.cgz,/osimage/pkg/debian-x86_64-2018-04-03.cgz/fio-x86_64-3.15-1_2019-10-10.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/mpstat_2019-10-10.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/vmstat_2019-10-11.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/turbostat_2019-10-11.cgz,/osimage/pkg/debian-x86_64-2018-04-03.cgz/turbostat-x86_64-3.7-4_2019-10-11.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/perf_2019-10-10.cgz,/osimage/pkg/debian-x86_64-2018-04-03.cgz/perf-x86_64-bc88f85c6c09_2019-10-17.cgz,/osimage/pkg/debian-x86_64-2018-04-03.cgz/sar-x86_64-c582fe4-1_2019-10-10.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/hw_2019-10-09.cgz"
lkp_initrd: "/osimage/user/lkp/lkp-x86_64.cgz"
site: inn

#! /lkp/lkp/.src-20191022-191714/include/site/inn
LKP_CGI_PORT: 80
LKP_CIFS_PORT: 139
oom-killer: 
watchdog: 

#! runtime status
repeat_to: 2
schedule_notify_address: 

#! user overrides
queue_at_least_once: 0
kernel: "/pkg/linux/x86_64-rhel-7.6/gcc-7/a70e8083a91b17a7c77012f7746dbf29b5050e66/vmlinuz-5.4.0-rc4-00001-ga70e8083a91b1"
dequeue_time: 2019-10-26 15:32:36.899496399 +08:00

#! /lkp/lkp/.src-20191025-221333/include/site/inn
job_state: finished
loadavg: 33.67 23.12 9.99 1/727 7863
start_time: '1572075403'
end_time: '1572075614'
version: "/lkp/lkp/.src-20191025-221358"

--GBuTPvBEOL0MYPgd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=reproduce

 "modprobe" "nd_e820"
dmsetup remove_all
wipefs -a --force /dev/pmem0
wipefs -a --force /dev/pmem1
mkfs -t ext4 -q -F /dev/pmem0
mkfs -t ext4 -q -F /dev/pmem1
mkdir -p /fs/pmem0
mount -t ext4 -o dax /dev/pmem0 /fs/pmem0
mkdir -p /fs/pmem1
mount -t ext4 -o dax /dev/pmem1 /fs/pmem1

for cpu_dir in /sys/devices/system/cpu/cpu[0-9]*
do
	online_file="$cpu_dir"/online
	[ -f "$online_file" ] && [ "$(cat "$online_file")" -eq 0 ] && continue

	file="$cpu_dir"/cpufreq/scaling_governor
	[ -f "$file" ] && echo "performance" > "$file"
done

echo '
[global]
bs=4k
ioengine=mmap
iodepth=32
size=4473924266
direct=0
runtime=200
invalidate=1
fallocate=posix
group_reporting

time_based

[task_0]
rw=rw
directory=/fs/pmem0
numjobs=24

[task_1]
rw=rw
directory=/fs/pmem1
numjobs=24' | fio --output-format=json -
umount /fs/pmem0
umount /fs/pmem1

--GBuTPvBEOL0MYPgd
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

--GBuTPvBEOL0MYPgd--
